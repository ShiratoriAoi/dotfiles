
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

function chtd() {
    local pathtd="$HOME/Dev/Projects/MyLibrary/PrivateMemos/ToDo/td.txt"
    touch $pathtd
    local td=`cat $pathtd`

    if [ $# -eq 0 ] ; then
        echo 'help: -h'
        echo `head -n 1 $pathtd`
    elif [ "$1" = "-h" ] ; then
        echo "chtd"             # show a task
        echo "chtd show"        # show all tasks
        echo "chtd stack"       # add stack todo
        #echo "chtd <tag>stack"  # add stack todo to tagged position
        echo "chtd queue"       # add queue todo
        #echo "chtd <tag>queue"  # add queue todo to tagged position
        echo "chtd -h"          # help
    elif [ "$1" = "stack" ] ; then
        sed -i "1i$2" "$pathtd"
    elif [ "$1" = "queue" ] ; then
        sed -i "a $2" "$pathtd"
    elif [ "$1" = "show" ] ; then
        cat $pathtd
    fi
    #cat queue.txt | grep -n "^- " | sed "s/:.*$//"
}




