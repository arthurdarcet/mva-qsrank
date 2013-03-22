function hashcodes = hashcodes(scores, K)
%HASHCODES Calculate the K first bits of the hashcodes
%   K must be lower than 64
    hashcodes = scores(:,1:K)>0;
end

