function lesionVolume(fnms)

if ~exist('fnms','var')
    fnms = spm_select(inf,'.mat','Select image[s] for NaN removal');
end

for i=1:size(fnms,1)
    fnm = deblank(fnms(i,:));
    lesionVolumeSub(fnm);
end

function lesionVolumeSub(fnm)
m = load(fnm);
if ~isfield(m,'lesion'), return; end
vol = sum(m.lesion.dat(:));
totalVol = numel(m.lesion.dat(:));
fprintf('%s\t%d\n', vol, totalVol);
