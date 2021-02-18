#!/bin/bash
#$ -S /bin/bash
####export FREESURFER_HOME=/Applications/freesurfer
####source $FREESURFER_HOME/SetUpFreeSurfer.sh
####export SUBJECTS_DIR=/Users/zhipeng/Desktop/ALC10522/derivatives/freesurfer


echo "<html>" 						>> ENIGMA_Cortical_QC_ex.html
echo "<table>"                              >> ENIGMA_Cortical_QC_ex.html


for sub in $(ls ${SUBJECTS_DIR});
do
freeview -f $SUBJECTS_DIR/$sub/surf/lh.pial:edgethickness=0:annot=aparc.annot --viewport '3d' -cam zoom 1.19  --viewsize 600 600 -ss ${sub}.lh.lat
freeview -f $SUBJECTS_DIR/$sub/surf/lh.pial:edgethickness=0:annot=aparc.annot --viewport '3d' -cam zoom 1.05 azimuth 180 --viewsize 600 600 -ss ${sub}.lh.med
freeview -f $SUBJECTS_DIR/$sub/surf/rh.pial:edgethickness=0:annot=aparc.annot --viewport '3d' -cam zoom 1.05  --viewsize 600 600 -ss ${sub}.rh.med
freeview -f $SUBJECTS_DIR/$sub/surf/rh.pial:edgethickness=0:annot=aparc.annot --viewport '3d' -cam zoom 1.19 azimuth 180 --viewsize 600 600 -ss ${sub}.rh.lat


echo "<tr>"                                                                                  >> ENIGMA_Cortical_QC_ex.html
echo "<td><a href=\"file:"$sub".lh.lat.png\"><img src=\""$sub".lh.lat.png\" width=\"300\" height=\"300\"></a></td>"		>> ENIGMA_Cortical_QC_ex.html
echo "<td><a href=\"file:"$sub".lh.med.png\"><img src=\""$sub".lh.med.png\" width=\"300\" height=\"300\"></a></td>"		>> ENIGMA_Cortical_QC_ex.html
echo "<td><a href=\"file:"$sub".rh.lat.png\"><img src=\""$sub".rh.lat.png\" width=\"300\" height=\"300\"></a></td>"		>> ENIGMA_Cortical_QC_ex.html
echo "<td><a href=\"file:"$sub".rh.med.png\"><img src=\""$sub".rh.med.png\" width=\"300\" height=\"300\"></a></td>"		>> ENIGMA_Cortical_QC_ex.html
echo "</tr>"															>> ENIGMA_Cortical_QC_ex.html
echo "<tr>"															>> ENIGMA_Cortical_QC_ex.html
echo "<td colspan=4><center>"$sub"</center><br></td>"								>> ENIGMA_Cortical_QC_ex.html
echo "</tr>"															>> ENIGMA_Cortical_QC_ex.html


done;
echo "</table>"                                                                             >> ENIGMA_Cortical_QC_ex.html
echo "</html>"                                                                              >> ENIGMA_Cortical_QC_ex.html
