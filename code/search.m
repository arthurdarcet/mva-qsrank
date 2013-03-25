function results = search(scores, Q, epsilon, K1, K2, L)
    K1_filtered = qs_filter(scores, Q, 1:K1, epsilon, L);
    K2_filtered = K1_filtered(qs_filter(scores(K1_filtered, :), Q, 1:K1+K2, epsilon, inf));
    results = K2_filtered(NN_exact(scores(K2_filtered, :), Q, epsilon));
end

