#!/bin/bash

function check_one_git_status() {
    if [ -d "$1" ] ; then 
        #directory sonzai suru.
        local dotgit="$1/.git"
        if [ -e "$dotgit" ] ; then
            echo -e "\e[37;44;5m `basename "$1"` \e[m"
            echo "  $1"
            if [ $2 = "fetch" ] ; then
                git -C $1 fetch
            fi
            git -C $1 status -sb 
            echo "----------------------------------------------------------"
        else
            echo "dir found, .git not exist: $dotgit"
            echo "----------------------------------------------------------"
        fi
    else
        #directory sonzai sinai.
        echo "dir not found: $1"
    fi
}

function check_git_status() {
    echo "----------------------------------------------------------"
    while [ $# -gt 0 ] ; do
        check_one_git_status $1 "n"
        shift
    done
}

function check_git_status_with_fetch() {
    echo "----------------------------------------------------------"
    while [ $# -gt 0 ] ; do
        check_one_git_status $1 "fetch"
        shift
    done
}
