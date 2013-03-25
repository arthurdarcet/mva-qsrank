function res = recall(exacts, results)
% Recall loss = |exacts \inter results| / |exacts|
% Here results \subset exacts : recall = |results|/|exacts|
    res = 1 - length(results)/length(exacts);
end

