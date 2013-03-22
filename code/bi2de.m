function res = bi2de(B)
%BI2DE Converts binary to decimal format.
%       D = BI2DE(B) converts a binary vector to an uint64.
%           If B is a matrix, each row is interpreted separately
    if size(B, 1) > 1
        res = zeros(1, size(B, 1), 'uint64');
        parfor i=1:length(res)
            res(i) = bi2de(B(i,:));
        end
        return
    end
    if length(B) < 53 % Matlab limitation
        s = num2str(B);
        s(isspace(s)) = ''; % Matlab bug : '1 0 1' is considered an 5 bit number 
                            % when checked against the 52 limit.
        res = uint64(bin2dec(s));
        return
    end
    res = bitshift(bi2de(B(1:end-52)), 53) + bi2de(B(end-51:end));
end