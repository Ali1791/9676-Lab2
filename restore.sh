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

if [ -n "$(ls -A "$malicious_dir")" ]
then # not empty folder

    while true
    do
        files=("$malicious_dir"/*)

        for i in "${!files[@]}"
        do
            echo "$((i+1)). ${files[$i]}"
        done

        read -p "Choose a file: " choice
        file="${files[$((choice-1))]}"

        echo "1. Restore this file"
        echo "2. Permanently delete this file"
        echo "3. Leave this file as-is"

        read -p "Choose an option: " option

        case "$option" in
            1)
                mv "$file" "$dir/"
                echo "Restored $file to $dir."
                ;;
            2)
                rm "$file"
                echo "$file permanently deleted."
                ;;
            3)
                continue
                ;;
            *)
                echo "Invalid option."
                ;;
        esac
    done

else
    echo "No malicious files to review."
fi