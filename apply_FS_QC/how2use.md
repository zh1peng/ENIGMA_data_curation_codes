## Open a python IDE such as spyder and excute the code in python_functions.py

## Then setup and run the following codes:
### setup the study_code and BIDS directory 


```
study_code='COH111RBC'
study_dir=os.path.join('Z:\\Labs\\Mackey\\NERVELAB\\ENIGMA\\BIDS\\',study_code)
print('=================processing============='+study_code)
```
Note: this is the only thing you need to setup if everything is in right BIDS format. 
The following codes setup the files and apply the QC results to the extracted data. Running the following codes will give you the QCed files.
If you are using the functions with files at different locations, you need to specify the qc files, data files and output file.

#### setup the qc file location
```python
cortical_qc=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/QC_raters_notes/{}_cortical_*.xlsx'.format(study_code,study_code))
subcortical_qc=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/QC_raters_notes/{}_subcortical_*.xlsx'.format(study_code,study_code))
```
#### setup the data location
```python
VOL_data=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/Subcortical_Extraction/LandRvolumes.csv'.format(study_code))
TH_data=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/Cortical_Extraction/CorticalMeasuresENIGMA_ThickAvg.csv'.format(study_code))
SA_data=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/Cortical_Extraction/CorticalMeasuresENIGMA_SurfAvg.csv'.format(study_code))
```

#### setup output location
```python
qced_VOL_data=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/{}_QCed_LandRvolumes.csv'.format(study_code,study_code))
qced_TH_data=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/{}_QCed_CorticalMeasuresENIGMA_ThickAvg.csv'.format(study_code,study_code))
qced_SA_data=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC/{}_QCed_CorticalMeasuresENIGMA_SurfAvg.csv'.format(study_code,study_code))
```
### apply the qc functions
```python
# subocrital volume
subcortical_qc_file=glob.glob(subcortical_qc)
check_sub_list(VOL_data,subcortical_qc_file[0])
qced_vol_df=apply_subcorticalqc_to_VOL(VOL_data,subcortical_qc_file[0])
qced_vol_df.to_csv(qced_VOL_data,index = False)

# Cortical thickness   
cortical_qc_file=glob.glob(cortical_qc) # same file used by CT and SA
check_sub_list(TH_data,cortical_qc_file[0]) 
qced_TH_df=apply_corticalqc_to_TH(TH_data,cortical_qc_file[0])
qced_TH_df.to_csv(qced_TH_data, index = False)

# Surface area
check_sub_list(SA_data,cortical_qc_file[0]) 
qced_SA_df=apply_corticalqc_to_SA(SA_data,cortical_qc_file[0])
qced_SA_df.to_csv(qced_SA_data, index = False)
```

## Troubleshooting
1. Make sure the files and paths exisit.

2. Subject ID in QC files should be matched with that in data files.

