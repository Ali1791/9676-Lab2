#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Error: 2 arguments required"
    exit 1
fi

dir=$1
malicious_dir=$2

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

sleep 23

# Scan the directory for malicious files
scan()
{
    for file in "$dir"/*
    do
        if [[ -f "$file" ]]
        then
            if grep -Fxq "$(basename "$file")" whitelist 2>/dev/null
            then
                continue
            fi    
            if [[ "$file" == *.exe || "$file" == *.bat || "$file" == *.vbs || "$file" == *.scr || "$file" == *.ps1 ]] || grep -qiE 'virus|trojan|malware|worm|ransomware' "$file" 2>/dev/null
            then
                echo "$file is malicious and it is DELETED"
                cp "$file" "$malicious_dir/"
                rm "$file"
            fi
        fi
    done
}

if [ ! -f directory-info.last ]
then
    scan
    ls -l "$dir" > directory-info.last
else
    ls -l "$dir" > directory-info.new

    if ! cmp -s directory-info.last directory-info.new
    then
        scan
        ls -l "$dir" > directory-info.last
    fi
fi