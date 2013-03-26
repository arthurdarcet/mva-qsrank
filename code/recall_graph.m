clear all;
close all;
addpath('utils');
% Number of SIFT vector to load. ~4000*N bytes of RAM required
% N < 3e5 for the PCA to work
N = 3e5;

K1 = 16;
K2 = 48;
L = 50;
query = 1;
loaded = false;

epsilons = [200:25:250 250:5:350 350:50:450];
precalls = zeros(size(epsilons));
recalls = containers.Map('KeyType', 'uint32', 'ValueType', 'double');

recalls(200) = 1;
recalls(225) = 1;
recalls(250) = 3.333333e-01;
recalls(250) = 3.333333e-01;
recalls(255) = 2.857143e-01;
recalls(260) = 2.285714e-01;
recalls(265) = 2.200000e-01;
recalls(270) = 2.048193e-01;
recalls(275) = 1.693548e-01;
recalls(280) = 1.595745e-01;
recalls(285) = 1.428571e-01;
recalls(290) = 1.363636e-01;
recalls(295) = 1.160714e-01;
recalls(300) = 1.018767e-01;
recalls(305) = 9.266410e-02;
recalls(310) = 8.327250e-02;
recalls(315) = 7.399230e-02;
recalls(320) = 6.905260e-02;
recalls(325) = 6.245850e-02;
recalls(330) = 5.520500e-02;
recalls(335) = 4.932550e-02;
recalls(340) = 4.522270e-02;
recalls(345) = 4.146950e-02;
recalls(350) = 3.744850e-02;
recalls(350) = 3.744850e-02;
recalls(400) = 1.346170e-02;
recalls(450) = 5.967900e-03;

for i=1:length(epsilons)
    if not(recalls.isKey(epsilons(i)))
        if not(loaded)
            features = load_data(N);
            [~, scores] = pca(double(features'));
            Q = scores(query,:);
            loaded = true;
        end
        exacts = NN_exact(scores, scores(query, :), epsilons(i));
        res = search(scores, Q, epsilons(i), K1, K2, L);
        recalls(epsilons(i)) = recall(exacts, res);
    end
    precalls(i) = recalls(epsilons(i));
    fprintf('recalls(%i) = %d;\n', epsilons(i), precalls(i));
end 

plot(epsilons, precalls, '+-');
xlabel('epsilon', 'FontSize', 30, 'Interpreter', 'latex');
ylabel('Recall loss', 'FontSize', 30, 'Interpreter', 'latex');
title(sprintf('K1 = %i, K2 = %i, L = %i', K1, K2, L));

%%

clear all;
close all;
addpath('utils');
% Number of SIFT vector to load. ~4000*N bytes of RAM required
% N < 3e5 for the PCA to work
N = 3e5;

L = 50;
query = 1;
epsilons = [200 250 300 350];
loaded = false;

recalls = cell(size(epsilons));
for k=1:length(epsilons)
    recalls{k} = containers.Map('KeyType', 'uint32', 'ValueType', 'double');
end

K1s = [8:2:20];
precalls = zeros(length(K1s), length(epsilons));
recalls{1}(8) = 1;
recalls{1}(10) = 1;
recalls{1}(12) = 1;
recalls{1}(14) = 1;
recalls{1}(16) = 1;
recalls{1}(18) = 1;
recalls{1}(20) = 1;
recalls{2}(8) = 1;
recalls{2}(10) = 8.888889e-01;
recalls{2}(11) = 8.333333e-01;
recalls{2}(12) = 7.222222e-01;
recalls{2}(13) = 6.666667e-01;
recalls{2}(14) = 6.666667e-01;
recalls{2}(16) = 3.333333e-01;
recalls{2}(18) = 2.222222e-01;
recalls{2}(20) = 2.222222e-01;
recalls{3}(8) = 9.772118e-01;
recalls{3}(10) = 7.265416e-01;
recalls{3}(12) = 4.705094e-01;
recalls{3}(14) = 1.997319e-01;
recalls{3}(16) = 1.018767e-01;
recalls{3}(18) = 4.289544e-02;
recalls{3}(20) = 3.619303e-02;
recalls{4}(8) = 9.183463e-01;
recalls{4}(10) = 5.195831e-01;
recalls{4}(12) = 2.677508e-01;
recalls{4}(14) = 8.921209e-02;
recalls{4}(16) = 3.744847e-02;
recalls{4}(18) = 1.397160e-02;
recalls{4}(20) = 9.390747e-03;
for k=1:length(epsilons)
    for i=1:length(K1s)
        exacts = -1;
        if not(recalls{k}.isKey(K1s(i)))
            if not(loaded)
                features = load_data(N);
                [~, scores] = pca(double(features'));
                Q = scores(query,:);
                loaded = true;
            end
            if exacts == -1
                exacts = NN_exact(scores, scores(query, :), epsilons(k));
            end
            res = search(scores, Q, epsilons(k), K1s(i), 64-K1s(i), L);
            recalls{k}(K1s(i)) = recall(exacts, res);
        end
        precalls(i,k) = recalls{k}(K1s(i));
        fprintf('recalls{%i}(%i) = %d;\n', k, K1s(i), precalls(i,k));
    end
end
figure
plot(K1s, precalls, '+-');
legend(...
    sprintf('epsilon = %i', epsilons(1)),...
    sprintf('epsilon = %i', epsilons(2)),...
    sprintf('epsilon = %i', epsilons(3)),...
    sprintf('epsilon = %i', epsilons(4))...
);
xlabel('$K_1$', 'FontSize', 30, 'Interpreter', 'latex');
ylabel('Recall loss', 'FontSize', 30, 'Interpreter', 'latex');
title(sprintf('L = %i', L));