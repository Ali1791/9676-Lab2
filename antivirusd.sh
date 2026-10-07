#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Error: 3 arguments required"
    exit 1
fi

dir=$1
malicious_dir=$2
interval_secs=$3

# Check if the directory exists
if [ ! -d "$dir" ]
then
    echo "Error: directory does not exist"
    exit 1
fi

# Check if the malicious directory exists
if [ ! -d "$malicious_dir" ]
then
    echo "Error: malicious directory does not exist"
    exit 1
fi

# Scan the directory for malicious files
scan()
{
    for file in "$dir"/*
    do
        if [[ -f "$file" ]] && { [[ "$file" == *.exe || "$file" == *.bat || "$file" == *.vbs || "$file" == *.scr || "$file" == *.ps1 ]] || grep -qiE 'virus|trojan|malware|worm|ransomware' "$file" 2>/dev/null; }
        then
            echo "$file is malicious and it is DELETED"
            cp "$file" "$malicious_dir/"
            rm "$file"
        fi
    done
}

if [ ! -f directory-info.last ]
then
    scan
    ls -l "$dir" > directory-info.last
fi

while true
do
    ls -l "$dir" > directory-info.new

    if ! cmp -s directory-info.last directory-info.new
    then
        scan
        cp directory-info.new directory-info.last
    fi

    sleep "$interval_secs"
done