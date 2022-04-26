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
