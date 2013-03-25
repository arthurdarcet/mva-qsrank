function res = qs_filter(scores, Q, bits, e, L)
%QS_FILTER Filter the the input based on the QsRank
%   RES = QS_FILTER(SCORES, QUERY, BITS, EPSILON, L) returns the indexes of the
%   L data buckets closest to QUERY according to the (QUERY,BITS,EPSILON)-QsRank
    [hashmap, codes] = hashcodes(scores, bits);
    ranks = qs_rank(Q(1, bits), codes, e);
    [~, indexes] = sort(-ranks);
    if isfinite(L)
        indexes = indexes(1:L);
    end
    size(ranks)
    res = extract_indexes(hashmap, indexes, ranks);
end

function res = extract_indexes(hashmap, indexes, ranks)
%EXTRACT_INDEXES
%   Concatenate the values stored in the keys hashmap.keys(indexes)
    res = [];
    keys = hashmap.keys;
    for i=1:length(indexes)
        %if ranks(indexes(i)) == 0
        %    return
        %end
        res = [res hashmap(keys{indexes(i)})];
    end
end
