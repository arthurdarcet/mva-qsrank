function [hashcodes_map, hashcodes] = hashcodes(scores, bits)
%HASHCODES Calculate the hashmap mapping K first bits of the hashcodes to
%the points indexes
%   K must be lower than 64
    bin_hashcodes = bi2de(scores(:,bits)>0);
    hashcodes_map = containers.Map('KeyType', 'uint64', 'ValueType', 'any');
    for i=1:length(bin_hashcodes)
        B = bin_hashcodes(i);
        if not(hashcodes_map.isKey(B))
            hashcodes_map(B) = [];
        end
        hashcodes_map(B) = [hashcodes_map(B) i];
    end
    keys = hashcodes_map.keys;
    hashcodes = zeros(length(keys), length(bits));
    for i=1:size(hashcodes, 1)
        points = hashcodes_map(keys{i});
        hashcodes(i, :) = scores(points(1), bits)>0;
    end
end

