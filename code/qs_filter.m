function res = qs_filter(scores, Q, bits, e, L)
%QS_FILTER Filter the the input based on the QsRank
%   RES = QS_FILTER(SCORES, QUERY, BITS, EPSILON, L) returns the indexes of the
%   L data points closest to QUERY according to the (QUERY,BITS, EPSILON)-QsRank
    [hashmap, codes] = hashcodes(scores, bits);
    ranks = qs_rank(Q(1, bits), codes, e);
    [~, indexes] = sort(-ranks);
    res = extract_indexes(hashmap, indexes(1:L));
end

function res = extract_indexes(hashmap, indexes)
%EXTRACT_INDEXES
%   Concatenate the values stored in the keys hashmap.keys(indexes)
    res = [];
    keys = hashmap.keys;
    for i=1:length(indexes)
        res = [res hashmap(keys{indexes(i)})];
    end
end
