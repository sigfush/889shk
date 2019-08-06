clear all
expr_order = {'mfdswaRest' 'mfdswRest' 'fdswaRest' 'fdswRest'};

cd ~/Documents/code/sigfus/
[num, txt, raw] = xlsread ('bdnf_rest_sequences.xlsx');
for i = 2:size (txt, 1)
    cd /Volumes/MasterChief/Master_In
    subj_id = txt{i, 1};
    study = txt{i, 5};
    if study(1) ~= 'n'
        if isdir (subj_id)
            cd (subj_id);
            idx = 1;
            filename = [];
            while isempty (filename) && idx <= length (expr_order)
                expr = [expr_order{idx} '_' subj_id '_' study '.nii'];
                if exist (expr, 'file')
                    filename = expr;
                    inpath = pwd;
                end
                idx = idx + 1;
            end
               
            if ~isempty (filename)
                cd /Volumes/GRIGORI/sigfus_fc/
                mkdir (subj_id);
                cd (subj_id);
                outpath = pwd;
                copyfile ([inpath '/' filename], [outpath '/' filename]);
                
            else
                disp ([subj_id ': no rest']);
            end

            cd ..
        else
            disp (['!!!!!!! no folder for ' subj_id]);
        end
    end
end

