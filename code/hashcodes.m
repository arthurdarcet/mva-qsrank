function [hashcodes] = hashcodes(features, K)
%HASHCODES Calculate the K first bits of the hashcodes
%   K must be lower than 64
    [~, scores] = pca(double(features'));
    hashcodes = bi2de(scores(:,1:K)>0);
end

