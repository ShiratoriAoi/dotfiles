#!/bin/bash

function check_status() {
    if [ -d "$1" ] ; then 
        #directory sonzai suru.
        dotgit="$1/.git"
        if [ -e "$dotgit" ] ; then
            echo -e "\e[37;44;5m `basename "$1"` \e[m"
            echo "    $1"
            git status | sed 's/^/    /' | grep --color=auto -e '$' -e 'Untracked files:'
            echo "----------------------------------------------------------"
        else
            echo "dir found, .git not exist: $dotgit"
        fi
    else
        #directory sonzai sinai.
        echo "dir not found: $1"
    fi
}

echo "----------------------------------------------------------"
while [ $# -gt 0 ] ; do
    check_status $1
    shift
done
echo "----------------------------------------------------------"
