# Functions used for generating FS_QC folder to do visual inspection

## How to use
1. download generate_FS_QC and unzip it.
    
    **ENIGMA_FS_QC_BIDS_version.m** is what you need to run.

2. requirements:
  
    a. it requires the **Freesurfer output** are stored in the following format:
     
     directory2study/study_ID/derivatives/freesurfer/sub-1
     
     directory2study/study_ID/derivatives/freesurfer/sub-2
     
     This is not mandatory, but recommanded. You can change line 21,23 to fit other format.
  
    b. it requires Freesurfer and R installed
  
    c. it requires interactive session, that means command line mode on HPC will not work


3. things to change in **ENIGMA_FS_QC_BIDS_version.m**
   
     a. BIDS_dir: this is the directory to the study folder
   
     b. STUDY_ID: this is the folder's name of the study
   
     c. R_dir: where you installed R
   
     d. str2search: prefix of the subject folder; if you use 'sub', then 'sub*' will be used to search subjects folder under
                  directory2study/study_ID/derivatives/freesurfer/
   
     e. FUN_dir: where you unzipped this repo
   
     f. **(line 110)setup_fs**: this is the command used on your system to set up freesurfer. 
   
4. run **ENIGMA_FS_QC_BIDS_version.m**
   
   the code will generate a folder named as x_FS_QC under derivatives contains all the output
   
   5 folders will be genreated under x_FS_QC folder:
   
     a. Cortical_External: contains external QC images; **ENIGMA_Cortical_QC_ex.html** can load all subjects' external QC images.
   
     b. Cortical_Extraction: contains extracted cortical thickness and surface area data.
   
     c. Cortical_Internal: contains internal QC images; **ENIGMA_Cortical_QC.html** can load all subjects' internal QC images.
   
     d. Subcortical_Extraction: contains extracted subcortical volume data.
   
     e. Subcortical_Segment: contains subcortical images for each subject; There are **8 HTML files** can load all subjects' subcortical QC images.
   
   
   
   





