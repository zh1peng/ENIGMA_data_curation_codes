Extract Destrieux CT data
```
# $1 -> BIDS_dir
# $2 -> study_code e.g., ALC125
# $3 -> search pattern, e.g., "sub-"
# example: ./Destrieux_test.sh /z/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS ALC134 sub-

printf "BIDS dir is: %s\n" "$1"
printf "Extracting Destrieux Data for %s with search string: %s\n" "$2" "$3"

BIDS_dir=$1
study_code=$2
fs_dir='/derivatives/freesurfer/'


study_dir=$BIDS_dir'/'$study_code$fs_dir
cd $study_dir

echo 'SubjID, L_G_and_S_frontomargin_thickavg, L_G_and_S_occipital_inf_thickavg, L_G_and_S_paracentral_thickavg, L_G_and_S_subcentral_thickavg, L_G_and_S_transv_frontopol_thickavg, L_G_and_S_cingul-Ant_thickavg, L_G_and_S_cingul-Mid-Ant_thickavg, L_G_and_S_cingul-Mid-Post_thickavg, L_G_cingul-Post-dorsal_thickavg, L_G_cingul-Post-ventral_thickavg, L_G_cuneus_thickavg, L_G_front_inf-Opercular_thickavg, L_G_front_inf-Orbital_thickavg, L_G_front_inf-Triangul_thickavg, L_G_front_middle_thickavg, L_G_front_sup_thickavg, L_G_Ins_lg_and_S_cent_ins_thickavg, L_G_insular_short_thickavg, L_G_occipital_middle_thickavg, L_G_occipital_sup_thickavg, L_G_oc-temp_lat-fusifor_thickavg, L_G_oc-temp_med-Lingual_thickavg, L_G_oc-temp_med-Parahip_thickavg, L_G_orbital_thickavg, L_G_pariet_inf-Angular_thickavg, L_G_pariet_inf-Supramar_thickavg, L_G_parietal_sup_thickavg, L_G_postcentral_thickavg, L_G_precentral_thickavg, L_G_precuneus_thickavg, L_G_rectus_thickavg, L_G_subcallosal_thickavg, L_G_temp_sup-G_T_transv_thickavg, L_G_temp_sup-Lateral_thickavg, L_G_temp_sup-Plan_polar_thickavg, L_G_temp_sup-Plan_tempo_thickavg, L_G_temporal_inf_thickavg, L_G_temporal_middle_thickavg, L_Lat_Fis-ant-Horizont_thickavg, L_Lat_Fis-ant-Vertical_thickavg, L_Lat_Fis-post_thickavg, L_Medial_wall_thickavg, L_Pole_occipital_thickavg, L_Pole_temporal_thickavg, L_S_calcarine_thickavg, L_S_central_thickavg, L_S_cingul-Marginalis_thickavg, L_S_circular_insula_ant_thickavg, L_S_circular_insula_inf_thickavg, L_S_circular_insula_sup_thickavg, L_S_collat_transv_ant_thickavg, L_S_collat_transv_post_thickavg, L_S_front_inf_thickavg, L_S_front_middle_thickavg, L_S_front_sup_thickavg, L_S_interm_prim-Jensen_thickavg, L_S_intrapariet_and_P_trans_thickavg, L_S_oc_middle_and_Lunatus_thickavg, L_S_oc_sup_and_transversal_thickavg, L_S_occipital_ant_thickavg, L_S_oc-temp_lat_thickavg, L_S_oc-temp_med_and_Lingual_thickavg, L_S_orbital_lateral_thickavg, L_S_orbital_med-olfact_thickavg, L_S_orbital-H_Shaped_thickavg, L_S_parieto_occipital_thickavg, L_S_pericallosal_thickavg, L_S_postcentral_thickavg, L_S_precentral-inf-part_thickavg, L_S_precentral-sup-part_thickavg, L_S_suborbital_thickavg, L_S_subparietal_thickavg, L_S_temporal_inf_thickavg, L_S_temporal_sup_thickavg, L_S_temporal_transverse_thickavg, R_G_and_S_frontomargin_thickavg, R_G_and_S_occipital_inf_thickavg, R_G_and_S_paracentral_thickavg, R_G_and_S_subcentral_thickavg, R_G_and_S_transv_frontopol_thickavg, R_G_and_S_cingul-Ant_thickavg, R_G_and_S_cingul-Mid-Ant_thickavg, R_G_and_S_cingul-Mid-Post_thickavg, R_G_cingul-Post-dorsal_thickavg, R_G_cingul-Post-ventral_thickavg, R_G_cuneus_thickavg, R_G_front_inf-Opercular_thickavg, R_G_front_inf-Orbital_thickavg, R_G_front_inf-Triangul_thickavg, R_G_front_middle_thickavg, R_G_front_sup_thickavg, R_G_Ins_lg_and_S_cent_ins_thickavg, R_G_insular_short_thickavg, R_G_occipital_middle_thickavg, R_G_occipital_sup_thickavg, R_G_oc-temp_lat-fusifor_thickavg, R_G_oc-temp_med-Lingual_thickavg, R_G_oc-temp_med-Parahip_thickavg, R_G_orbital_thickavg, R_G_pariet_inf-Angular_thickavg, R_G_pariet_inf-Supramar_thickavg, R_G_parietal_sup_thickavg, R_G_postcentral_thickavg, R_G_precentral_thickavg, R_G_precuneus_thickavg, R_G_rectus_thickavg, R_G_subcallosal_thickavg, R_G_temp_sup-G_T_transv_thickavg, R_G_temp_sup-Lateral_thickavg, R_G_temp_sup-Plan_polar_thickavg, R_G_temp_sup-Plan_tempo_thickavg, R_G_temporal_inf_thickavg, R_G_temporal_middle_thickavg, R_Lat_Fis-ant-Horizont_thickavg, R_Lat_Fis-ant-Vertical_thickavg, R_Lat_Fis-post_thickavg, R_Medial_wall_thickavg, R_Pole_occipital_thickavg, R_Pole_temporal_thickavg, R_S_calcarine_thickavg, R_S_central_thickavg, R_S_cingul-Marginalis_thickavg, R_S_circular_insula_ant_thickavg, R_S_circular_insula_inf_thickavg, R_S_circular_insula_sup_thickavg, R_S_collat_transv_ant_thickavg, R_S_collat_transv_post_thickavg, R_S_front_inf_thickavg, R_S_front_middle_thickavg, R_S_front_sup_thickavg, R_S_interm_prim-Jensen_thickavg, R_S_intrapariet_and_P_trans_thickavg, R_S_oc_middle_and_Lunatus_thickavg, R_S_oc_sup_and_transversal_thickavg, R_S_occipital_ant_thickavg, R_S_oc-temp_lat_thickavg, R_S_oc-temp_med_and_Lingual_thickavg, R_S_orbital_lateral_thickavg, R_S_orbital_med-olfact_thickavg, R_S_orbital-H_Shaped_thickavg, R_S_parieto_occipital_thickavg, R_S_pericallosal_thickavg, R_S_postcentral_thickavg, R_S_precentral-inf-part_thickavg, R_S_precentral-sup-part_thickavg, R_S_suborbital_thickavg, R_S_subparietal_thickavg, R_S_temporal_inf_thickavg, R_S_temporal_sup_thickavg, R_S_temporal_transverse_thickavg' >CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv

for subj_id in $(ls -d "$3"*/); do
printf "%s,"  "${subj_id%%/}" >> CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv
for side in lh.aparc.a2009s.stats rh.aparc.a2009s.stats; do
for x in G_and_S_frontomargin G_and_S_occipital_inf G_and_S_paracentral G_and_S_subcentral G_and_S_transv_frontopol G_and_S_cingul-Ant G_and_S_cingul-Mid-Ant G_and_S_cingul-Mid-Post G_cingul-Post-dorsal G_cingul-Post-ventral G_cuneus G_front_inf-Opercular G_front_inf-Orbital G_front_inf-Triangul G_front_middle G_front_sup G_Ins_lg_and_S_cent_ins G_insular_short G_occipital_middle G_occipital_sup G_oc-temp_lat-fusifor G_oc-temp_med-Lingual G_oc-temp_med-Parahip G_orbital G_pariet_inf-Angular G_pariet_inf-Supramar G_parietal_sup G_postcentral G_precentral G_precuneus G_rectus G_subcallosal G_temp_sup-G_T_transv G_temp_sup-Lateral G_temp_sup-Plan_polar G_temp_sup-Plan_tempo G_temporal_inf G_temporal_middle Lat_Fis-ant-Horizont Lat_Fis-ant-Vertical Lat_Fis-post Medial_wall Pole_occipital Pole_temporal S_calcarine S_central S_cingul-Marginalis S_circular_insula_ant S_circular_insula_inf S_circular_insula_sup S_collat_transv_ant S_collat_transv_post S_front_inf S_front_middle S_front_sup S_interm_prim-Jensen S_intrapariet_and_P_trans S_oc_middle_and_Lunatus S_oc_sup_and_transversal S_occipital_ant S_oc-temp_lat S_oc-temp_med_and_Lingual S_orbital_lateral S_orbital_med-olfact S_orbital-H_Shaped S_parieto_occipital S_pericallosal S_postcentral S_precentral-inf-part S_precentral-sup-part S_suborbital S_subparietal S_temporal_inf S_temporal_sup S_temporal_transverse; do
printf "%g," `grep -w ${x} ${subj_id}/stats/${side} | awk '{print $5}'` >> CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv

done
done
echo "" >> CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv
done
fs_qc_folder=$study_code"_FS_QC"
printf "CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv to %s \n" "$fs_qc_folder" 
mv $study_dir/CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv $study_dir'/'$fs_qc_folder'/'$study_code"_CorticalMeasuresENIGMA_Destrieux_ThickAvg.csv"
```

Important notes:
* In the for loop no need to add `,` 
* When creating ROI name, do not replace "L_" or "R_" with "". Some ROI name will be changed.
* In Excel, use `=Textjoin(", ", 1, A1:A75)` to join string with ", "
* In Excel, use `RIGHT(A16,LEN(A16)-2)` to remove prefix
