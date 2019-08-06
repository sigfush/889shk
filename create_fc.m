clear all
cd /Volumes/GRIGORI/sigfus_fc/
d = dir ('M*');
for i = 1:length (d)
    if isdir (d(i).name)
        cd (d(i).name);
        % to create the MAT file from nifti
        nii_nii2mat ('trunc_rest.nii', 3);
        
        % to change the filename
        copyfile ('trunc_rest.mat', ['../matfiles/' d(i).name '.mat']);
        
        cd ('..');
    end
end