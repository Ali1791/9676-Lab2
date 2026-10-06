#!/bin/bash

dir=$1
malicious_dir=$2
interval_secs=$3

ls -l "$dir" > directory-info.last

while true
do
    ls -l "$dir" > directory-info.new

    if ! cmp -s directory-info.last directory-info.new
    then
        for file in "$dir"/*
        do
            if [[ "$file" == *.exe || "$file" == *.bat || "$file" == *.vbs || "$file" == *.scr || "$file" == *.ps1 ]] || grep -qiE 'virus|trojan|malware|worm|ransomware' "$file"
            then
                echo "$file is malicious and it is DELETED"

                cp "$file" "$malicious_dir/"
                rm "$file"
            fi
        done

        cp directory-info.new directory-info.last
    fi

    sleep "$interval_secs"
done