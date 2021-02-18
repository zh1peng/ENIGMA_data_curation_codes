#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 24 18:32:36 2020
This code is to copy neccesary files for generating QC output images
@author: zhipeng
"""
import os
import glob
import shutil
data_path=input('enter the data set path (e.g. /Users/zhipeng/Desktop/ALC115): ')
fs_dir=os.path.join(data_path,'derivatives/freesurfer')
file2copy=['/mri/orig.mgz',
'/mri/aparc+aseg.mgz',
'/surf/lh.pial',
'/surf/rh.pial',
'/surf/rh.orig',
'/surf/lh.orig',
'/surf/rh.white',
'/surf/lh.white',
'/stats/aseg.stats',
'/stats/lh.aparc.stats',
'/stats/rh.aparc.stats',
'/label/lh.aparc.annot',
'/label/rh.aparc.annot',
'/mri/transforms/talairach.xfm']

file2search=[fs_dir+'/*'+n   for n in file2copy]
for file_i in file2search:
    src_files=list(glob.glob(file_i))
    dst_folder=[os.path.dirname(n.replace('freesurfer','FS_QC_input_files')) for n in src_files]
    for n in range(len(src_files)):
        dst_dir=dst_folder[n]
        if not os.path.exists(dst_dir):
            os.makedirs(dst_dir)
        shutil.copy(src_files[n],dst_dir)
