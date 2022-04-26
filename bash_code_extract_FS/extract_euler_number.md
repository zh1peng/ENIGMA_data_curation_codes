Single subject, assuming you are in the stat/ folder
```
echo 'SubjID,L_SurfaceHoles, L_Euler, R_SurfaceHoles, R_Euler, Total_SurfaceHoles, Total_Euler'>Euler_number.csv
printf "%s,"  "sub001" >> Euler_number.csv
for x in lhSurfaceHoles, rhSurfaceHoles, "Total number of"; do

hole=$(grep "${x}" ./aseg.stats |  tr -dc '0-9')
let g=$hole euler=2-2*g # 2-2g

#echo $hole
#echo $euler 
printf "%s," "$hole" >>Euler_number.csv
printf "%s," "$euler" >>Euler_number.csv
done
```
Mutiple subjects, assuming you are in the freesufer/ folder and searching pattern that start with 'sub'

```
echo 'SubjID,L_SurfaceHoles, L_Euler, R_SurfaceHoles, R_Euler, Total_SurfaceHoles, Total_Euler'>Euler_number.csv


for subj_id in $(ls -d sub-*/); do
printf "%s,"  "${subj_id%%//}" >> Euler_number.csv
for x in lhSurfaceHoles, rhSurfaceHoles, "Total number of"; do

hole=$(grep "${x}" ./${subj_id}/stats/aseg.stats |  tr -dc '0-9')
let g=$hole euler=2-2*g # 2-2g

#echo $hole
#echo $euler 
printf "%s," "$hole" >>Euler_number.csv
printf "%s," "$euler" >>Euler_number.csv

done
echo "" >> Euler_number.csv
done
```


Final version 
allows to specify 
* 1 BIDS_dir
* 2 study_code
* 3 search pattern

saves the output into {study_code}_FS_QC folder as {study_code}_Euler_Number.csv
```
# $1 -> BIDS_dir
# $2 -> study_code e.g., ALC125
# $3 -> search pattern, e.g., "sub-"
# example: ./euler_test.sh /z/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS ALC125 sub-

printf "BIDS dir is: %s\n" "$1"
printf "Extracting Euler Number for %s with search string: %s\n" "$2" "$3"

BIDS_dir=$1
study_code=$2
fs_dir='/derivatives/freesurfer/'


study_dir=$BIDS_dir'/'$study_code$fs_dir
cd $study_dir
echo 'SubjID,L_SurfaceHoles, L_Euler, R_SurfaceHoles, R_Euler, Total_SurfaceHoles, Total_Euler'>Euler_number.csv

for subj_id in $(ls -d "$3"*/); do
printf "%s,"  "${subj_id%%//}" >> Euler_number.csv
for x in lhSurfaceHoles, rhSurfaceHoles, "Total number of"; do

hole=$(grep "${x}" ./${subj_id}/stats/aseg.stats |  tr -dc '0-9')
let g=$hole euler=2-2*g # 2-2g

#echo $hole
#echo $euler 
printf "%s," "$hole" >>Euler_number.csv
printf "%s," "$euler" >>Euler_number.csv

done
echo "" >> Euler_number.csv
done

printf "Finished \n" 

fs_qc_folder=$study_code"_FS_QC"
printf "Moveing Euler_number.csv to %s \n" "$fs_qc_folder" 
mv $study_dir/Euler_number.csv $study_dir'/'$fs_qc_folder'/'$study_code"_Euler_number.csv"

```



