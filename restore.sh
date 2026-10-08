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

while true
do
    files=("$malicious_dir"/*)

    # Check if malicious_dir is empty
    if [ ! -e "${files[0]}" ]
    then
        echo "No malicious files to review."
        break
    fi

    # List the files
    for i in "${!files[@]}"
    do
        echo "$((i + 1)): ${files[$i]}"
    done

    read -p "Choose a file: " choice

    # Check that the choice is a valid number
    if ! [[ "$choice" =~ ^[0-9]+$ ]] ||  [ "$choice" -lt 1 ] ||  [ "$choice" -gt "${#files[@]}" ]
    then
        echo "Invalid choice."
        continue
    fi

    file="${files[$((choice - 1))]}"

    echo "For $file:"
    echo "1: Restore this file back into dir (it was a false positive)"
    echo "2: Permanently delete this file from malicious_dir (it was genuinely malicious)"
    echo "3: Go back"

    read -p "> " option

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