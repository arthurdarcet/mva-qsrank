function res = NN_exact(scores, query, epsilon)
%NN_EXACT Return the exact epsilon-Nearest Neighbour for query in features
    res = [];
    dist = @(t) sqrt(sum(t.*t));
    for i=1:size(scores,1)
        if dist(scores(i,:) - query) <= epsilon
            res = [res i];
        end
    end
end