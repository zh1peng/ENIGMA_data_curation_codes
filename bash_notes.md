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

