function [feat, names] = load_data(feat_dir)
%LOAD_DATA Load the SIFT represantations and the corresponding images names
%   Arguments:
%       - feat_dir [default: '../data/features'] : directory to load from
    FEAT_FILE = 'feat_oxc1_hesaff_sift.bin';
    NAME_FILE = 'README2.txt';
    
    if nargin < 1
        feat_dir = fullfile('..', 'data', 'features');
    end

    fid = fopen(fullfile(feat_dir, NAME_FILE), 'r');
    names_cell = textscan(fid, '%s', 'HeaderLines', 20);
    names = names_cell{1};
    fclose(fid);
    
    fid = fopen(fullfile(feat_dir, FEAT_FILE), 'r');
    feat = fread(fid, [128,length(names)], 'uint8=>uint8');
    fclose(fid);
end

