function res = recall(exacts, results)
% Recall loss = |exacts \inter results| / |exacts|
% Here results \subset exacts : recall = |results|/|exacts|
    res = length(results)/length(exacts);
end

