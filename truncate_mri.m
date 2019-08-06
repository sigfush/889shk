clear all
cd /Volumes/GRIGORI/sigfus_fc/
d = dir ('M*');
for i = 1:length (d)
    if isdir (d(i).name)
        cd (d(i).name);
        d1 = dir ('*Rest*.nii');
        hdr = spm_vol (d1(1).name);
        if length (hdr) > 196
            t_hdr = hdr (1:196);
        else
            t_hdr = hdr;
        end
        spm_file_merge (t_hdr, 'trunc_rest.nii');
        cd ('..');
    end
end