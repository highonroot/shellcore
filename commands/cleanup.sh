#!/bin/bash

path="$1"

[ -z "$path" ] && echo "Provide a path" && exit 1

[ ! -d "$path" ] && echo "Error: Not a directory: $path" && exit 1

read -p "Enter file extension to clean (e.g. tmp, bak, log): " ext
ext=$(echo "$ext" | sed 's/^\.//')

[ -z "$ext" ] && echo "Extension cannot be empty" && exit 1

case "$ext" in
  *[!a-zA-Z0-9]*) echo "Invalid extension: $ext"; exit 1 ;;
esac

echo ""

count_files=$(find "$path" -type f -name "*.${ext}" | wc -l | awk '{print $1}')

if [ "$count_files" -eq 0 ]; then
    echo "No *.${ext} files found in $path"
    exit 0
fi

echo "Found $count_files *.${ext} files in $path"
echo ""

size_before=$(du -sbL "$path" | awk '{print $1}')

while true; do
    echo ""
    read -p "Show files before deleting? (y/n): " confirm_show
    confirm_show=$(echo "$confirm_show" | tr 'A-Z' 'a-z')

    echo ""
    if [ "$confirm_show" = "y" ]; then
        echo "Files:"
        find "$path" -type f -name "*.${ext}"
        break
    elif [ "$confirm_show" = "n" ]; then
        echo "Skipping file listing"
        break
    else
        echo "Invalid input. Please enter y or n."
    fi
done

echo ""

while true; do
    echo ""
    read -p "Delete all *.${ext} files in $path? (y/n): " confirm_del
    confirm_del=$(echo "$confirm_del" | tr 'A-Z' 'a-z')

    echo ""
    if [ "$confirm_del" = "y" ]; then
        find "$path" -type f -name "*.${ext}" -delete
        echo "$count_files *.${ext} files deleted successfully"
        break
    elif [ "$confirm_del" = "n" ]; then
        echo "Deletion terminated"
        exit 0
    else
        echo "Invalid input. Please enter y or n."
    fi
done

size_after=$(du -sbL "$path" | awk '{print $1}')
freed=$((size_before - size_after))

echo ""
echo "Space before : $(numfmt --to=iec "$size_before" 2>/dev/null || echo "$size_before bytes")"
echo "Space after : $(numfmt --to=iec "$size_after" 2>/dev/null || echo "$size_after bytes")"
echo "Freed       : $(numfmt --to=iec "$freed" 2>/dev/null || echo "$freed bytes")"
