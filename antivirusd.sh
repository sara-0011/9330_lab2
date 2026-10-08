dir=$1
malicious_dir=$2
interval-secs=$3
check_file() {
    local file="$1"
    if [[ "$file" == *.exe ]] || [[ "$file" == *.bat ]] || [[ "$file" == *.vbs ]] || [[ "$file" == *.scr ]] || [[ "$file" == *.ps1 ]]; then
    return 0;
    fi
    if grep -q -i -E "virus|trojan|malware|worm|ransomware" "$file"; then
    return 0;
    fi
    return 1;

}
if [ -z "$(ls -A "$dir")" ]; then
echo "The directory is empty."
else
for file in "$dir"/*; do
     if ! check_file "$file"; then
     filename=$(basename "$file)
     new_path="$malicious_dir/$filename"
     echo "$filename is malicious and it is DELETED" 
     mv "$file" "$new_path"
     fi
done
ls -l dir > directory-info.last
while true; do
if ! cmp -s directory-info.last "$dir"; then
for file in "$dir"/*; do
     if ! check_file "$file"; then
     filename=$(basename "$file)
     new_path="$malicious_dir/$filename"
     echo "$filename is malicious and it is DELETED" 
     mv "$file" "$new_path
     fi
done
ls -l dir > directory-info.last
fi
sleep "$interval-secs"
done


