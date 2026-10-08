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