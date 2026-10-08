#!/bin/bash
dir=$1
malicious_dir=$2

print_files() {  
if [ -z "$(ls -A "$malicious_dir")" ]; then
echo "No malicious files to review."
return 1;
else
files=( "$malicious_dir"/* )
i=1
for file in "${files[@]}"; do
    echo "$i. $(basename "$file")"
    ((i++))
done
fi
read -p "please pick a file or e to exit: " file_num
if [[ $file_num == "e" ]]; then
return 1
fi
file_number=$((file_num - 1))
} 
print_options() {
    echo "please pick an option :"
    echo "1: Restore this file back into dir"
    echo "2: Permanently delete this file from malicious_dir"
    echo "3: Leave this file as-is and go back to the list"
    read -p "Enter option: " option 
}
while true; do
if ! print_files; then
echo "exiting"
break
fi
selected="${files[$file_number]}"
filename=$(basename "$selected")
print_options
if [[ $option == 1 ]]; then
new_path="$dir/$filename"
mv "$selected" "$new_path"
echo "Restored $filename to $dir."
fi
if [[ $option == 2 ]]; then
rm "$selected"
echo "$filename permanently deleted."
fi
if [[ $option == 3 ]]; then
echo "Leaving this file as-is"
fi
done