function feat = load_data(N, feat_dir)
%LOAD_DATA Load the SIFT represantations and the corresponding images names
%   Arguments:
%       - feat_dir [default: '../data/features'] : directory to load from
    FEAT_FILE = 'feat_oxc1_hesaff_sift.bin';    
    if nargin < 2
        feat_dir = fullfile('..', 'data', 'features');
    end

    fid = fopen(fullfile(feat_dir, FEAT_FILE), 'r');
    feat = fread(fid, [128,N], 'uint8=>uint8');
    fclose(fid);
end

