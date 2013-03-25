clear all;
close all;
addpath('utils');
% Number of SIFT vector to load. ~4000*N bytes of RAM required
% N < 3e5 for the PCA to work
N = 3e5;

features = load_data(N);

K1 = 16;
K2 = 48;
L = 50;
query = 1;

[~, scores] = pca(double(features'));
Q = scores(query,:);


epsilons = [200:25:250 250:5:350 350:50:400];
precalls = zeros(size(epsilons));
recalls = containers.Map('KeyType', 'uint32', 'ValueType', 'double');
recalls(200) = 0;
recalls(225) = 0;
recalls(250) = 6.666667e-01;
recalls(255) = 7.142857e-01;
recalls(260) = 7.714286e-01;
recalls(265) = 7.800000e-01;
recalls(270) = 7.951807e-01;
recalls(275) = 8.306452e-01;
recalls(280) = 8.404255e-01;
recalls(285) = 8.571429e-01;
recalls(290) = 8.636364e-01;
recalls(295) = 8.839286e-01;
recalls(300) = 8.981233e-01;
recalls(305) = 9.073359e-01;
recalls(310) = 9.167275e-01;
recalls(315) = 9.260077e-01;
recalls(320) = 9.309474e-01;
recalls(325) = 9.375415e-01;
recalls(330) = 9.447950e-01;
recalls(335) = 9.506745e-01;
recalls(340) = 9.547773e-01;
recalls(345) = 9.585305e-01;
recalls(350) = 9.625515e-01;
recalls(375) = 9.781091e-01;
recalls(400) = 9.865383e-01;
recalls(425) = 9.914997e-01;
recalls(450) = 9.940321e-01;

for i=1:length(epsilons)
    if not(recalls.isKey(epsilons(i)))
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