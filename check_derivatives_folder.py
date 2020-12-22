study_id=[]
folder_n=[]
all_subdir=glob.glob(r'Z:\Groups\Psychiatry\General\NERVELAB\ENIGMA\BIDS\*/')
for idx, study_dir in enumerate(all_subdir):
    study_code=os.path.basename(os.path.dirname(study_dir))
    study_id.append(study_code)
    
    study_dir=os.path.join(study_dir,'derivatives')
    if os.path.exists(study_dir):
        fnname=[n for n in os.listdir(study_dir) if os.path.isdir(os.path.join(study_dir,n))]
        folder_n.append(len(fnname))
    else:
        folder_n.append(0)
df=pd.DataFrame([study_id,folder_n]).T
