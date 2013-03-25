function res = qs_rank(q, h, e)
%QS_RANK Compute the QsRank approximation for a gaussian distribution of data
%       R = QS_RANK(Q, H, e)
%           R is the collumn vector such as R(i) is the QS-Rank of the
%           hashcode H(:, i) against the query point Q.
    A = (1 + repmat(q, size(h,1), 1) .* h ./ e) ./ 2;
    A(A>1) = 1;
    A(A<0) = 0;
    res = sum(log(A),2);
end

