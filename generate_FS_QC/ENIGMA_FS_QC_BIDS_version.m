%% This code simplies the steps in ENIGMA QC protocal and works for the BIDS format
% How to use
% 1. download all files and put one directory (Note no space in directory)
% 2. sepcify 
%       R directory where you install R
%       STUDY_id (e.g., ALC115)
%       BIDS_dir (e.g., /Volumes/shared/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS)
%       str2search: pattern of the subject id
%       FUN_dir: where you store the related ENIGMA QC functions
% 3. all QC output will be generated in .../derivatives/FS_QC
% 4. matlab/R/shell are needed


STUDY_id='NIC118'
BIDS_dir='/Volumes/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS'
R_dir='/usr/local/bin/R'
str2search='sub' % sub string before *, you will search ca*
FUN_dir='/Users/zhipeng/Documents/QC_FUNS'
addpath(genpath(FUN_dir))

FS_QC_dir=fullfile(BIDS_dir, STUDY_id, sprintf('derivatives/%s_FS_QC',STUDY_id))
system(sprintf('mkdir %s', FS_QC_dir))
FS_SUB_dir=fullfile(BIDS_dir, STUDY_id, 'derivatives/freesurfer')



%% STEP 0 Check if the files
file2check={'/mri/orig.mgz',
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
'/mri/transforms/talairach.xfm'};
a=dir(char(strcat(FS_SUB_dir,'/',str2search,'*')));
a=a([a.isdir]) %select dir
all_sub={};
test_exist=[];
bad_sub={};
for x = 1:size(a,1)
[c,b,d]=fileparts(a(x,1).name);
    f2check=fullfile(FS_SUB_dir, b, file2check);
    test_exist=[test_exist,cell2mat(cellfun(@exist, f2check,'Unif',0))];
    if sum(cell2mat(cellfun(@exist, f2check,'Unif',0)))<28
    disp([num2str(x),':',b, ' -->less 28'])
    end
    if sum(cell2mat(cellfun(@exist, f2check,'Unif',0)))<26
        disp([num2str(x),':',b, '-->less 26 fs incomplete!'])
        bad_sub=[bad_sub,b];
    end
    all_sub=[all_sub,b];
end
if ~isempty(bad_sub)
disp('moving bad subjects to FS_incomplete')
FS_incomplete_dir=fullfile(BIDS_dir, STUDY_id, 'derivatives/FS_incomplete');
system(sprintf('mkdir %s', FS_incomplete_dir))
for subi=1:length(bad_sub)
    system(sprintf('mv %s %s',fullfile(FS_SUB_dir, bad_sub{subi}),FS_incomplete_dir))
end
end
%% STEP 1 Cortical extraction 
extract_sh=fullfile(FUN_dir,'cortical_extract_zp.sh')
outlier_R=fullfile(FUN_dir,'cortical_outliers.R')
Cortical_extract_dir=fullfile(FS_QC_dir, 'Cortical_Extraction')
system(sprintf('mkdir %s', Cortical_extract_dir)) % make extraction dir
cd(Cortical_extract_dir)
system(sprintf('source %s %s %s',  extract_sh, FS_SUB_dir, str2search)) 
system(sprintf('mv %s/CorticalMeasuresENIGMA*.csv %s', FS_SUB_dir, Cortical_extract_dir))
% outlier detection
system(sprintf(	'%s --no-save --slave < %s> outliers.txt',R_dir, outlier_R))


% make hist plots
histplot_R=fullfile(FUN_dir,'ENIGMA_CorticalROI_plots.R')
Hist_plot_dir=fullfile(Cortical_extract_dir,'Hist_plots')
system(sprintf('mkdir %s', Hist_plot_dir))
cd(Hist_plot_dir)
system(sprintf('cp %s/CorticalMeasures*.csv %s', Cortical_extract_dir, Hist_plot_dir))
system(sprintf(	'%s --no-save --slave < %s >outliers.log ',R_dir, histplot_R))


%% STEP 2 Cortical internal QC
Cortical_internal_dir=fullfile(FS_QC_dir, 'Cortical_Internal')
system(sprintf('mkdir %s', Cortical_internal_dir)) 
a=dir(char(strcat(FS_SUB_dir,'/',str2search,'*')));
a=a([a.isdir]) %select dir
for x = 1:size(a,1)
    [c,b,d]=fileparts(a(x,1).name); %b becomes the subject_name
    try
        func_make_corticalpngs_ENIGMA_QC(Cortical_internal_dir, b, [FS_SUB_dir, '/', b, '/mri/orig.mgz'], [FS_SUB_dir,'/', b, '/mri/aparc+aseg.mgz']);
    end
    display(['Done with subject: ', b, ': ', num2str(x), ' of ', num2str(size(a,1))]);
end
webpage_sh=fullfile(FUN_dir,'make_ENIGMA_QC_webpage.sh')
system(sprintf('sh %s %s', webpage_sh, Cortical_internal_dir))


%% STEP 3 Cortical external QC
Cortical_external_dir=fullfile(FS_QC_dir, 'Cortical_External')
system(sprintf('mkdir %s', Cortical_external_dir)) 

external_sh=fullfile(FUN_dir,'cortical_external_qc_freeview.sh')
setup_fs='export FREESURFER_HOME=/Applications/freesurfer; source $FREESURFER_HOME/SetUpFreeSurfer.sh'

cd (Cortical_external_dir)
system(sprintf('%s; export SUBJECTS_DIR=%s; source %s', setup_fs, FS_SUB_dir, external_sh))

%% STEP 4 Subcortical extraction
extract_sh=fullfile(FUN_dir,'subcortical_extract_zp.sh')
outlier_sh=fullfile(FUN_dir,'subcortical_outliers.sh')

Subcortical_extract_dir=fullfile(FS_QC_dir, 'Subortical_Extraction')
system(sprintf('mkdir %s', Subcortical_extract_dir)) % make extraction dir
cd(Subcortical_extract_dir)
system(sprintf('source %s %s %s',  extract_sh, FS_SUB_dir, str2search)) 
system(sprintf('mv %s/LandRvolumes.csv* %s', FS_SUB_dir, Subcortical_extract_dir))

% make plots
histplot_R=fullfile(FUN_dir,'ENIGMA_SubcorticalROI_plots.R')
Hist_plot_dir=fullfile(Subcortical_extract_dir,'Hist_plots')
system(sprintf('mkdir %s', Hist_plot_dir))
cd(Hist_plot_dir)
system(sprintf('cp %s/LandRvolumes.csv %s', Subcortical_extract_dir, Hist_plot_dir))
system(sprintf(	'%s --no-save --slave < %s> outliers.log',R_dir, histplot_R))

% outlier detection
system(sprintf('sh %s %s >outliers.txt', outlier_sh, Hist_plot_dir))
system(sprintf('mv  %s/outliers.txt  %s', Hist_plot_dir, Subcortical_extract_dir))
%% STEP 5 Subcortical Segment QC
Subcortical_seg_dir=fullfile(FS_QC_dir, 'Subortical_Segment')
system(sprintf('mkdir %s', Subcortical_seg_dir))

a=dir(char(strcat(FS_SUB_dir,'/',str2search,'*')));
a=a([a.isdir]) %select dir
for x = 1:size(a,1)
    [c,b,d]=fileparts(a(x,1).name); %b becomes the subject_name
try
func_make_subcorticalFS_ENIGMA_QC(Subcortical_seg_dir, b, [FS_SUB_dir,'/', b, '/mri/orig.mgz'], [FS_SUB_dir,'/',b, '/mri/aparc+aseg.mgz']);
end
display(['Done with subject: ', b,': ',num2str(x), ' of ', num2str(size(a,1))]);
end

cd(Subcortical_seg_dir)
webpage_sh=fullfile(FUN_dir,'make_subcortical_ENIGMA_QC_webpage.sh')
system(sprintf('sh %s %s', webpage_sh, Subcortical_seg_dir))


