function [Vectors,  Ap, Values] = pca( A, p )
%	linear PCA function
%	input:	- A			: data to project
%			- p			: number of direction to keep
%	output:	- Ap		: projected data
%			- Vectors	: p first eigenvectors of the centered Gram matrix
%			- Values	: p first eigenvalues of the centered Gram matrix

s = size(A);
n = s(1)

% compute gram matrix
G = zeros(n,n);
for i = 1:n
    for j = 1:n
          G(i,j) = sum(A(i,:).*A(j,:));
    end
end

% compute centered Gram Matrix
U = ones(n,n)/n;
Gc = G - U*G - G*U + U*G*U;

% compute eigen vectors
[Vectors,Values]=eig(Gc);

% sort the eigen vectors
[Vectors,Values] = sortem(Vectors,Values);
Values = diag(Values);
size(Vectors)

% select p values
Values = Values(1:p);
Vectors = Vectors(:, 1:p);

% normalize vectors
for i=1:p
    Vectors(:,i) = Vectors(:,i)/sqrt(Values(i));
end
size(Vectors(:,2))

% project the data
for i=1:p
    Ap(i, :) = Vectors(:,i)'*Gc'
end

end

function [vectors, values] = sortem(vectors, values)
    vals = max(values);						% create a row vector containing only the eigenvalues
    [svals inds] = sort(vals,'descend');	% sort the row vector and get the indicies
    vectors = vectors(:,inds);				% sort the vectors according to the indicies from sort
    values = max(values(:,inds));			% sort the eigenvalues according to the indicies from sort
    values = diag(values);					% place the values into a diagonal matrix
end

