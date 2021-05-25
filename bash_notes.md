# remove text after v1

`for f in *; do
echo mv - "$f" "${f%%\v1*}";
done

[output]
mv -n sub-6123v1_T1w-1815234-1 sub-6123
mv -n sub-6127v1_T1w-1815234-2 sub-6127
`

[ref](https://unix.stackexchange.com/questions/506861/how-to-remove-all-characters-after-and-including-in-filename)
