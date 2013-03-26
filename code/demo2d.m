clear all;
close all;
addpath('utils');

n = 500;

data = 2*randn(n, 2);
K1 = 1;
K2 = 1;
L = 1;
R = 1;
epsilon = 5;
query = [-1 1];

[basis, scores] = pca(double(data));
Q = (basis' / query)';

tic
K1_filtered = qs_filter(scores, Q, 1:K1, epsilon, L);
K2_filtered = K1_filtered(qs_filter(scores(K1_filtered, :), Q, K1+1:K1+K2, epsilon, R));
toc

pp = @(d, c, s) plot(d(:,1), d(:,2), c, 'markersize', s);
figure
hold on
plot([0 basis(1,1)], [0, basis(2,1)], 'k-');
plot([0 basis(1,2)], [0, basis(2,2)], 'k-');
pp(data, 'b.', 6);
pp(data(K1_filtered, :), 'ro', 8);
pp(data(K2_filtered, :), 'gs', 12);
plot(query(1), query(2), 'c.', 'markersize', 20);