#!/bin/bash
dir=$1
malicious_dir=$2
interval_secs=$3
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


