study_id=[]
missing_subn=[]
# Find out what is missing for the incomplete files manualy
# move to qc folder
all_subdir=glob.glob(r'Z:\Groups\Psychiatry\General\NERVELAB\ENIGMA\BIDS\*/')
for idx, study_dir in enumerate(all_subdir):
    # 1. search STUDY+FS_QC move to freesurfer
    # get study_code
    study_code=os.path.basename(os.path.dirname(study_dir))
    study_id.append(study_code)
    
    qc_dir=os.path.join(study_dir,'derivatives/freesurfer/{}_FS_QC'.format(study_code))
    
    missing_dir=os.path.join(study_dir,'derivatives/FS_incomplete')
    if os.path.exists(missing_dir):
        missing_subn.append(len(os.listdir(missing_dir)))
        if os.path.exists(qc_dir):
            shutil.move(missing_dir,qc_dir)
    else:
        missing_subn.append(0)
df=pd.DataFrame([study_id,missing_subn],index=['study_id','missing_subn']).T
