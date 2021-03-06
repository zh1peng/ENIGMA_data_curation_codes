study_codes=('COC116' 'COC117' 'COH111' 'NIC106' 'NIC113' 'NIC115' 'NIC119')
search_strs=('sub' 'sub' 'Heitzeg' 'BISCUE' 'ASCC' 'smk' 'sub')

base_dir='L:/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS/'
fs_dir='/derivatives/freesurfer/'

sh_file='C:/Users/zcao4/Desktop/extract_fs_remote_version.sh'

for i in "${!study_codes[@]}"; do
printf "%s is running with search string: %s\n" "${study_codes[i]}" "${search_strs[i]}"
study_dir=$base_dir${study_codes[i]}$fs_dir
source $sh_file $study_dir ${search_strs[i]}

study_qc_dir=$study_dir//${study_codes[i]}_FS_QC
study_cortical_data_dir=$study_qc_dir/Cortical_Extraction
study_subcortical_data_dir=$study_qc_dir/Subortical_Extraction
mv $study_dir/CorticalMeasuresENIGMA*.csv $study_cortical_data_dir
mv $study_dir/LandRvolumes.csv $study_subcortical_data_dir


done




