setwd('Z:/Labs/Mackey/NERVELAB/ENIGMA/BIDS/ALC108/derivatives/freesurfer')
subfolders=dir(path = ".", pattern='^sub-',full.names = TRUE)
subid.org=lapply(subfolders, get_subid_orig)


df=data.frame(subdir=subfolders,
              subid.orig=unlist(subid.org))
  

get_subid_orig <- function(subfolder){
  logfile=file.path(subfolder,'/scripts/recon-all.log')
  dir.history=read.csv(logfile, header = F)[2,]
  subid.orig=sub('-out','',basename(dir.history))
  return(subid.orig)
}
