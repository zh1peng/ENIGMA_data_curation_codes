all_subdir=glob.glob(r'Z:\Groups\Psychiatry\General\NERVELAB\ENIGMA\BIDS\*/')
for idx, study_dir in enumerate(all_subdir):
    # 1. search STUDY+FS_QC move to freesurfer
    # get study_code
    study_code=os.path.basename(os.path.dirname(study_dir))
    print('=================processing============='+study_code)
    qc_old_dir=os.path.join(study_dir,'derivatives/FS_QC_old'.format(study_code))
    qc_dir=os.path.join(study_dir,'derivatives/{}_FS_QC'.format(study_code))
    fs_dir=os.path.join(study_dir,'derivatives/freesurfer')
    zip_file=os.path.join(study_dir,'derivatives/{}_FS_QC.zip'.format(study_code))
    if os.path.exists(qc_dir):
        if os.path.exists(qc_old_dir):
            shutil.move(qc_old_dir,qc_dir)
        if os.path.exists(zip_file):
            shutil.move(zip_file,qc_dir)
        shutil.move(qc_dir,fs_dir)
