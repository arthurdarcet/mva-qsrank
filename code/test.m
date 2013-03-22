clear all;
[f, n] = load_data();
K = 64;
epsilon = 10;
query = floor(rand()*length(n)) + 1;

[basis, scores] = pca(double(f'));
H = hashcodes(scores, K);
Q = scores(query,1:K);
R = qs_rank(Q, H, epsilon);
sprintf('Query: %s', n(query));
sprintf('Results:', n(query));
n(R>0)