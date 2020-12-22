import os
import shutil
import pandas as pd
import time
import glob

all_subdir=glob.glob(r'L:\Groups\Psychiatry\General\NERVELAB\ENIGMA\BIDS\*/')

#BIDS_dir=r'Z:\Groups\Psychiatry\General\NERVELAB\ENIGMA\BIDS'
#all_subdir=[n for n in os.listdir(BIDS_dir) if os.path.isdir(os.path.join(BIDS_dir,n))]

# zip fs qc files
# if STUDY+FS_QC exists:
#     record it
#     check freesurfer folder to see how many participants    
#    if zip file not exists:
#        zip the STUDY+FS_QC
#        record zip time 
#        record if the file is zipped
#        shutil.make_archive(r'C:\Users\Zhipeng\Desktop\test', 'zip', r'C:\Users\Zhipeng\Desktop\test')

study_id=[]
study_subn=[]
study_qc_folder=[]
study_qc_zipped=[]
time_per_zipsub=[]
for idx, study_dir in enumerate(all_subdir):
    # 1. search STUDY+FS_QC move to freesurfer
    # get study_code
    study_code=os.path.basename(os.path.dirname(study_dir))
    print('=================processing============='+study_code)
    study_id.append(study_code)
    qc_dir=os.path.join(study_dir,'derivatives/{}_FS_QC'.format(study_code))
    fs_dir=os.path.join(study_dir,'derivatives/freesurfer')
    zip_file=os.path.join(study_dir,'derivatives/{}_FS_QC.zip'.format(study_code))
    
    # check subn in fs_dir
    if os.path.exists(fs_dir):
        subname=[n for n in os.listdir(fs_dir) if os.path.isdir(os.path.join(fs_dir,n))]
        study_subn.append(len(subname))
    else:
        study_subn.append(0)
    
    # check if FS_qc exists
    if os.path.exists(qc_dir):
        study_qc_folder.append(1)
        if os.path.isfile(zip_file):
            study_qc_zipped.append(1)
            time_per_zipsub.append(999)
        else:
            start = time.time()
            shutil.make_archive(qc_dir, 'zip', qc_dir)
            end = time.time()
            time_eslaped=(start-end)/60
            time_per_zipsub.append(time_eslaped)
            study_qc_zipped.append(1)
            print('=========zipped file done========='+str(time_eslaped))
    else:
        study_qc_folder.append(0)
        study_qc_zipped.append(0)
        time_per_zipsub.append(0)
    
df=pd.DataFrame([study_id,study_qc_folder, study_qc_zipped, study_subn,time_per_zipsub],
                index=['study_id','study_qc', 'study_qc_zipped', 'study_subn','time_per_zipsub']).T
    

df.to_csv(r'C:/Users/zcao4/Desktop/qc_zip_file.csv')
