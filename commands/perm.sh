#!/bin/bash

#test
f_name="$1"

[ -z "$f_name" ] && echo "Provide filename" && exit 1

if [ ! -f "$f_name" ]
then
    echo "Error: File not found: $f_name"
    exit 1
fi

perm=$( stat -c "%A" "$f_name" )

#Slicing ${variable:index:length} length -> number of character
case "${perm:0:1}" in
    -) ftype="Regular file" ;;
    d) ftype="Directory" ;;
    l) ftype="Link" ;;
    *) ftype="Other Type" ;;
esac

show_permissions(){
    start="$1"
    label="$2"

        echo "$label Permissions:"
        if [ "${perm:$start:1}" = 'r' ]
        then
            echo "      Readable: true"
        else
            echo "      Readable: false"
        fi

        if [ "${perm:$((start+1)):1}" = 'w' ]
        then
            echo "      Writable: true"
        else
            echo "      Writable: false"
        fi

        if [ "${perm:$((start+2)):1}" = 'x' ]
        then
            echo "      Executable: true"
        else
            echo "      Executable: false"
        fi

        echo "--------------------------"
}

echo ""
echo "Type: $ftype"
echo "Permissions for $f_name: $perm"
echo ""
show_permissions 1 "Owner"
show_permissions 4 "Group"
show_permissions 7 "Others"

echo ""
[ "${perm:8:1}" = 'w' ] && echo -e  "\033[0;31m Warning: File is World-writable\033[0m"
[ "${perm:9:1}" = 'x' ] && echo -e  "\033[0;31m Warning: File is World-executable\033[0m"
