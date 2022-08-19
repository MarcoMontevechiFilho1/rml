#!/bin/bash

#USAGE: MAIN.SH FILE FOLDER FOLDER1 FOLDER2 FOLDER3...
#WILL MOVE FILE TO FOLDER AND CHECK FOLDER1, 2 AND 3 FOR SYMLINKS

OLD_PWD=$PWD

symlink_checker () { #checks recursively if symbolic links are inside folder. Stores links in arrays.
    local -n ARRAY=$1
    while IFS= read -r -d $'\0';
    do
        ARRAY+=("$REPLY");
    done < <(find ~+ -type l -print0)
}
###CHECKING IF FILE OR FOLDER OR NONE
if [ -d $1 ]
    then TYPE="FOLDER";
elif [ -f $1 ]
    then TYPE="FILE";
else TYPE="UNKNOWN";
fi
###GETTING SEPARATED FILE NAME AND ABSOLUTE PATH
if [ $TYPE = "FOLDER" ]
    then cd $1;
        FINAL_PATH=$PWD;
        cd -
elif [ $TYPE = "FILE" ]
    then
	JUST_FILENAME="$(basename -- $1)"
	path=`readlink -f "$1"`
	JUST_DIRNAME="$(dirname "$path")"
else
    exit 0
fi
###Using symlink checker to find symlinks
if [ -z $3 ] #if no $3, just do it in current folder
    then
        cd ./
        links=()
        symlink_checker links
else         #else, go trough every listed folder in args
	iterator=2
        at_array=( $@ )
        links=()
	while [ ! -z ${at_array[$iterator]} ]
        do
            cd ${at_array[$iterator]}
            symlink_checker links
            cd $OLD_PWD
            iterator=$iterator+1
        done
fi
echo ${links[@]}
#mv ${*: -2:1} ${*: -1:1} #actually moving file
