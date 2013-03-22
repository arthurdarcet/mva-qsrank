function S = join(t, filter)
    S = [sprintf('%s, ', t{filter(1:end-1)}), t{end}];
end

