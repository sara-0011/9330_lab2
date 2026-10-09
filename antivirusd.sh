#!/bin/bash
dir=$1
malicious_dir=$2
interval_secs=$3
check_file() {
    local file="$1"
    local filename=$(basename "$file")
    if grep -F -x -q "$filename" whitelist.txt; then
    return 1;
    fi
    if [[ "$file" == *.exe ]] || [[ "$file" == *.bat ]] || [[ "$file" == *.vbs ]] || [[ "$file" == *.scr ]] || [[ "$file" == *.ps1 ]]; then
    return 0;
    fi
    if grep -q -i -E "virus|trojan|malware|worm|ransomware" "$file"; then
    return 0;
    fi
    return 1;

}
scan_dir() {
for file in "$dir"/*; do
     if check_file "$file"; then
     filename=$(basename "$file")
     new_path="$malicious_dir/$filename"
     echo "$filename is malicious and it is DELETED" 
     mv "$file" "$new_path"
     fi
done
}
if [ -z "$(ls -A "$dir")" ]; then
echo "The directory is empty."
else
scan_dir
ls -l "$dir" > directory-info.last
while true; do
sleep "$interval_secs"
ls -l "$dir" > directory-info.current
if ! cmp -s directory-info.last directory-info.current; then
scan_dir
ls -l "$dir" > directory-info.last
fi
done
fi


