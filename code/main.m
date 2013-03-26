clear all;
addpath('utils');
% Number of SIFT vector to load. ~4000*N bytes of RAM required
% N < 3e5 for the PCA to work
N = 1e4;

K1 = 16;
K2 = 48;
L = 50;
epsilon = 150;

features = load_data(N);
query = floor(rand()*N) + 1;

[~, scores] = pca(double(features'));
Q = scores(query,:);

tic;
K1_filtered = qs_filter(scores, Q, 1:K1, epsilon, L);
toc; tic;
K2_filtered = qs_filter(scores(K1_filtered, :), Q, 1:K1+K2, epsilon, inf);
toc; tic;
results = K2_filtered(NN_exact(scores(K1_filtered(K2_filtered), :), Q, epsilon));
toc;

norm = @(t) sqrt(sum(t.*t));
dist = cell(1,length(K1_filtered));
for i=1:length(K1_filtered)
    dist{i} = [num2str(K1_filtered(i)) ' (' num2str(norm(Q-scores(K1_filtered(i),:))) ')'];
end

exacts = NN_exact(scores, Q, epsilon);

fprintf('Query: %i\n', query);
fprintf('K1 filtered (%i): %s\n', length(K1_filtered), [sprintf('%s, ', dist{1:end-1}), dist{end}]);
fprintf('K2 filtered (%i): %s\n', length(K2_filtered), [sprintf('%s, ', dist{K2_filtered(1:end-1)}), dist{K2_filtered(end)}]);
fprintf('Results     (%i): %s\n', length(results), [sprintf('%s, ', dist{results(1:end-1)}), dist{results(end)}]);
fprintf('Exacts      (%i): %s\n', length(exacts), [sprintf('%i, ', exacts(1:end-1)), num2str(exacts(end))]);
fprintf('Recall loss: %i\n', recall(exacts, K1_filtered(results)));