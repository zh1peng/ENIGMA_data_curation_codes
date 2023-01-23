import os
import shutil
import pandas as pd
import time
import glob




def check_sub_list(stat_file,qc_file):
    stat_df=pd.read_csv(stat_file)
    qc_df=pd.read_excel(qc_file)
    stat_file_sub=list(stat_df.loc[:,'SubjID'].dropna())
    qc_file_sub=list(qc_df.loc[:,'Subject'].dropna())
    intersect_sub = list(set.intersection(set(stat_file_sub), set(qc_file_sub)))
    missing_sub =list(set(stat_file_sub) - set(qc_file_sub))
    print('stat_file N: {} \b qc_file N: {} \b intersected N: {}'.format(len(stat_file_sub),len(qc_file_sub),len(intersect_sub)))
    print(missing_sub)

def apply_subcorticalqc_to_VOL(stat_file,qc_file):
    stat_df=pd.read_csv(stat_file)
    qc_df=pd.read_excel(qc_file)
    sub_list=list(stat_df.loc[:,'SubjID'].dropna())
    for stat_idx,subi in enumerate(sub_list):
        sub_qc=qc_df.loc[qc_df.loc[:,'Subject']==subi,:]
        sub_qc=sub_qc.iloc[0,3:].dropna()
        col2remove=[]
        left_list=list(sub_qc[sub_qc.apply(lambda x :'l' in x.lower())].index) # if l is in the cell
        if left_list:
            col2remove=col2remove+['L'+roi for roi in left_list]
        right_list=list(sub_qc[sub_qc.apply(lambda x :'r' in x.lower())].index)
        if right_list:
            col2remove=col2remove+['R'+roi for roi in right_list]
        
        if col2remove:        
            for col_i in col2remove:
                stat_df.loc[stat_idx,col_i]='n/a'
    return stat_df

def apply_corticalqc_to_SA(stat_file,qc_file):
    stat_df=pd.read_csv(stat_file)
    qc_df=pd.read_excel(qc_file)
    qc_df=qc_df.rename(columns={'parsopecularis':'parsopercularis'})
    sub_list=list(stat_df.loc[:,'SubjID'].dropna())
    for stat_idx,subi in enumerate(sub_list):
        sub_qc=qc_df.loc[qc_df.loc[:,'Subject']==subi,:]
        sub_qc=sub_qc.iloc[0,5:].dropna()
        col2remove=[]
        left_list=list(sub_qc[sub_qc.apply(lambda x :'l' in x.lower())].index) # if l is in the cell
        if left_list:
            col2remove=col2remove+['L_'+roi+'_surfavg' for roi in left_list]
        right_list=list(sub_qc[sub_qc.apply(lambda x :'r' in x.lower())].index)
        if right_list:
            col2remove=col2remove+['R_'+roi+'_surfavg' for roi in right_list]
        
        if col2remove:        
            for col_i in col2remove:
                stat_df.loc[stat_idx,col_i]='n/a'
    return stat_df

def apply_corticalqc_to_TH(stat_file,qc_file):
    stat_df=pd.read_csv(stat_file)
    qc_df=pd.read_excel(qc_file)
    qc_df=qc_df.rename(columns={'parsopecularis':'parsopercularis'})
    sub_list=list(stat_df.loc[:,'SubjID'].dropna())
    for stat_idx,subi in enumerate(sub_list):
        sub_qc=qc_df.loc[qc_df.loc[:,'Subject']==subi,:]
        sub_qc=sub_qc.iloc[0,5:].dropna()
        col2remove=[]
        left_list=list(sub_qc[sub_qc.apply(lambda x :'l' in x.lower())].index) # if l is in the cell
        if left_list:
            col2remove=col2remove+['L_'+roi+'_thickavg' for roi in left_list]
        right_list=list(sub_qc[sub_qc.apply(lambda x :'r' in x.lower())].index)
        if right_list:
            col2remove=col2remove+['R_'+roi+'_thickavg' for roi in right_list]
        
        if col2remove:        
            for col_i in col2remove:
                stat_df.loc[stat_idx,col_i]='n/a'
    return stat_df
