#!/bin/bash

path="$1"

[ -z "$path" ] && echo "Provide a path" && exit 1

if [ ! -e "$path" ]
then
    echo "Error: No file or directory found: $path"
    exit 1
fi

if [ -L "$path" ]; then
    path=$(realpath "$path")
fi

name=$(stat -c "%n" "$path")
type=$(stat -c "%F" "$path")

echo "Name: $name"
echo "Type: $type"
echo ""

file_info() {
    size=$(stat -c "%s" "$path")
    mtime=$(stat -c "%y" "$path")
    perms=$(stat -c "%A" "$path")

    echo "----- File Information -----"
    echo "Size          : ${size} bytes"
    echo "Last modified : $mtime"
    echo "Permissions   : $perms"
}

dir_info() {
    size=$(du -sh "$path" | awk '{print $1}')
    count_file=$(find "$path" -type f | wc -l | tr -d ' ')
    count_dir=$(find "$path" -type d | wc -l | tr -d ' ')
    count_dir=$((count_dir - 1))
    perms=$(stat -c "%A" "$path")

    echo "----- Directory Information -----"
    echo "Size           : $size"
    echo "Files          : $count_file"
    echo "Subdirectories : $count_dir"
    echo "Permissions    : $perms"
}

if [ -f "$path" ]
then
    file_info
elif [ -d "$path" ]
then
    dir_info
fi
