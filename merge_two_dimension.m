[filepath, filename]=filesearch_substring('Z:\Groups\Psychiatry\General\NERVELAB\ENIGMA\BIDS\OPI112\all_data','T1w.nii')

for n = 1:30

vol_info=spm_vol(fullfile(filepath{n},filename{n}));
a=spm_read_vols(vol_info);
b=cat(3,squeeze(a(:,:,:,1)),squeeze(a(:,:,:,2)));
info2write=vol_info(1)
info2write.fname=fullfile(fullfile(filepath{n},strcat('merged_', filename{n})))
%info2write.dim=size(b)
spm_write_vol(info2write,imresize3(b,[info2write.dim]))


end
