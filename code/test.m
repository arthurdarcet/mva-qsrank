clear all;
addpath('utils');

K1 = 40;
K2 = 10;
L = 10;
R = 3;
epsilon = 40;

[features, names] = load_data();
query = floor(rand()*length(names)) + 1;

[~, scores] = pca(double(features'));
Q = scores(query,:);

tic
K1_filtered = qs_filter(scores, Q, 1:K1, epsilon, L);
K2_filtered = K1_filtered(qs_filter(scores(K1_filtered, :), Q, K1+1:K1+K2, epsilon, R));
toc

results = K1_filtered;
fprintf('Query: %s\n',names{query});
fprintf('K1 filtered: %s\n', join(names, K1_filtered));
fprintf('K2 filtered: %s\n', join(names, K2_filtered));