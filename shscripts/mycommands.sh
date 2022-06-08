
source $HOME_DOTFILES/shscripts/git_status.sh

function chgit() {
    local REPO1=`find $HOME/Dev/Projects/Developing -maxdepth 1 -mindepth 1 -type d | tr "\n" " "`
    local REPO2=`find $HOME/Dev/Projects/MyLibrary  -maxdepth 1 -mindepth 1 -type d | tr "\n" " "`
    local REPO3="$HOME/Dev/dotfiles"
    local STR="$REPO1 $REPO2 $REPO3"

    if [ $# -eq 0 ] ; then
        #=→空白の箇所で単語分割
        check_git_status ${=STR}
    elif [ "$1" = "-h" ] ; then
        echo "chgit"
        echo "chgit fetch"
        echo "chgit ffmerge"
        echo "chgit cd <dir>"
        echo "chgit -h"
    elif [ "$1" = "cd" ] ; then
        cd `echo $STR | tr " " "\n" | grep "$2"`
    elif [ "$1" = fetch ] ; then
        check_git_status_with_fetch ${=STR}
    elif [ "$1" = ffmerge ] ; then
        check_git_status_with_merge ${=STR}
    fi 
}

