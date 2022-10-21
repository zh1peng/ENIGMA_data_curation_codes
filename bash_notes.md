## remove text after _T1w

```
# check what will happen?
for f in *; do
echo mv - "$f" "${f%%\_T1w*}";
done

[output]
mv -n sub-6123v1_T1w-1815234-1 sub-6123
mv -n sub-6127v1_T1w-1815234-2 sub-6127

# apply it
for f in *; do
mv $f ${f%%\_T1w*};
done

```

[ref](https://unix.stackexchange.com/questions/506861/how-to-remove-all-characters-after-and-including-in-filename)


## only extract some files from a zip file

```
for zipfile in *.zip;
do unzip -j "$zipfile" '*/*/*/*/*_3T_T1w_MPR1.nii.gz';
done

```


## remove file or folder that in/not in a list 
```
# print it  
for f in *; do
    if ! grep -Fxq "$f" folders_list.txt; then
        printf "Folder to remove -- %s \n" ${f} 
    else
        printf "Folder to Keep -- %s \n" ${f}
    fi
done

for f in *; do
if [ -d "$f" ]; then  # $f is a directory
    if ! grep -Fxq "$f" folders_list.txt; then
        printf "Folder to remove -- %s \n" ${f} 
    else
        printf "Folder to Keep -- %s \n" ${f}
    fi
   fi
done

# apply it
for f in *; do
    if ! grep -Fxq "$f" folders_list.txt; then
        printf "Folder to remove -- %s \n" ${f}
        rm -r "$f" 
    else
        printf "Folder to Keep -- %s \n" ${f}
    fi


for f in *; do
if [ -d "$f" ]; then  # $f is a directory
    if ! grep -Fxq "$f" folders_list.txt; then
        printf "Folder to remove -- %s \n" ${f}
        rm -r "$f" 
    else
        printf "Folder to Keep -- %s \n" ${f}
    fi
   fi
done

```

[ref-get folder in dir](https://unix.stackexchange.com/questions/86722/how-do-i-loop-through-only-directories-in-bash)

[ref](https://stackoverflow.com/questions/61845449/delete-files-and-folders-in-a-directory-which-dont-match-a-text-list)




## remove all folders
```
rm -R -- */
```

## unzip files
```
_start=0
for file_i in *.tar.gz; do
((_start=_start+1))
echo ${_start} ${file_i}
tar -zxf ${file_i} ${file_i%%_*}/T1_3DAXIAL/Dicoms
done
```

> s='/some/random/file.csv:some string'

> echo "${s%%:*}"

> /some/random/file.csv


#use z for gz file

#also can use pipe|
`gunzip -c foo.tar.gz | tar xopft -`

## dcm2niix batch 
```
sufix='_T1w'
prefix='sub-'
_start=0
for subj_id in $(ls -d */); do
((_start=_start+1))
echo ${_start} ${subj_id}
out=$prefix${subj_id%%/}$sufix
#dcm2niix  -f $out -o /Volumes/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS/COH106/sourcedata/all_T1 /Volumes/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS/COH106/sourcedata/Study_version2/${subj_id}/T1_3DAXIAL
done
```


## loop with start index

how to use seq: add `$seq(start end)`

how to get the length of array: `${#array[@]}`

> when use this approach, it is important to not that the index start with 0!!!!

how to get all index for array `${!array[@]}`

how to use seq: `$seq(start, end)`

how to remove end '/': `%%/`
```
sufix='_T1w'
prefix='sub-'
start=518
subid_array=($(ls -d */))
for subi in $(seq $start ${#subid_array[@]}); do
subj_id=${subid_array[$subi-1]} #idx start with 0
echo $subi $subj_id
out=$prefix${subj_id%%/}$sufix
dcm2niix  -f $out -o /Volumes/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS/COH106/sourcedata/all_T1 /Volumes/Groups/Psychiatry/General/NERVELAB/ENIGMA/BIDS/COH106/sourcedata/Study_version2/${subj_id}/T1_3DAXIAL
done
```

## show folder structure and save to file
```
tree -d -C -H ./ > result.html
```

### how to copy folders with centain patterns to new directory 
#### e.g., session 1 participants
sometimes it may need to use `**/*ses-1*` other wise only contents of the folder instead of the parent folder are copied
```
for d in **/*ses-1*/
do 
cp -r $d dest_path
done
```



