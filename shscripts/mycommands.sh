
source $HOME_DOTFILES/shscripts/git_status.sh

function chgit() {
    local REPO1=`find $HOME/Dev/Projects/Developing -maxdepth 1 -mindepth 1 -type d | tr "\n" " "`
    local REPO2=`find $HOME/Dev/Projects/MyLibrary  -maxdepth 1 -mindepth 1 -type d | tr "\n" " "`
    local REPO3="$HOME/Dev/dotfiles"
    local REPO4="$HOME/Dev/aoymoon"
    local STR="$REPO1 $REPO2 $REPO3 $REPO4"

    if [ $# -eq 0 ] ; then
        echo 'help: -h'
        #=→空白の箇所で単語分割
        check_git_status ${=STR}
    elif [ "$1" = "-h" ] ; then
        echo "chgit"
        echo "chgit fetch"
        echo "chgit ffmerge"
        echo "chgit clone <path: projects.txt>"
        echo "chgit cd <dir>"
        echo "chgit -h"
    elif [ "$1" = "cd" ] ; then
        cd `echo $STR | tr " " "\n" | grep "$2"`
    elif [ "$1" = fetch ] ; then
        check_git_status_with_fetch ${=STR}
    elif [ "$1" = ffmerge ] ; then
        check_git_status_with_merge ${=STR}
    elif [ "$1" = clone ] ; then 
        if [ $# -eq 2 ] ; then 
            if [ -e "$2" ] ; then
                clone_git_projects `cat "$2"`
            fi
        else
            echo "invalid input"
            echo "format: chgit clone <path>"
        fi
    fi 
}

function cht() {
    local pathtd="$HOME/Dev/Projects/MyLibrary/PrivateMemos/ToDo/td.txt"
    touch $pathtd
    local td=`cat $pathtd`

    if [ $# -eq 0 ] ; then
        echo `head -n 1 $pathtd`
    elif [ "$1" = "-h" ] ; then
        echo "cht"                    # show a task
        echo "cht show"               # show all tasks
        echo "cht stack <memo>"       # add stack todo
        echo "cht restack <number>"   # restack selected row
        echo "cht queue <memo>"       # add queue todo
        echo "cht done (<number>)"    # remove top todo
        echo "cht -h"                 # help
    elif [ "$1" = "stack" ] ; then
        sed -i "1i$2" "$pathtd"
    elif [ "$1" = "queue" ] ; then
        sed -i "$ a $2" "$pathtd"
    elif [ "$1" = "restack" ] ; then
        local a=`sed -n "$2P" "$pathtd"`
        sed -i "$2d" "$pathtd"
        sed -i "1i$a" "$pathtd"
    elif [ "$1" = "show" ] ; then
        cat -n $pathtd
    elif [ "$1" = "done" ] ; then
        if [ $# -eq 1 ] ; then
            sed -i "1d" "$pathtd"
        elif [ "$#" -eq 2 ] ; then
            sed -i "$2d" "$pathtd"
        fi
    fi
    #cat queue.txt | grep -n "^- " | sed "s/:.*$//"
}

function chall() {
    if [ $# -eq 0 ] ; then
        chgit
        echo '---------------------------'
        cht
    elif [ "$1" = "-h" ] ; then
        echo "chall"           # check all
        echo "chall -h"          # help
        echo '---------------------------'
        echo "chgit"
        echo "cht"
    elif [ "$1" = "stack" ] ; then
        sed -i "1i$2" "$pathtd"
    elif [ "$1" = "queue" ] ; then
        sed -i "$ a $2" "$pathtd"
    elif [ "$1" = "show" ] ; then
        cat $pathtd
    elif [ "$1" = "done" ] ; then
        if [ $# -eq 1 ] ; then
            sed -i "1d" "$pathtd"
        elif [ "$#" -eq 2 ] ; then
            sed -i "$2d" "$pathtd"
        fi
    fi
}


