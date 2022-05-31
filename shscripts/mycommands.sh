
source $HOME_DOTFILES/shscripts/git_status.sh

REPO1=`find $HOME/Dev/Projects/Developing -maxdepth 1 -mindepth 1 -type d | tr "\n" " "`
REPO2=`find $HOME/Dev/Projects/MyLibrary  -maxdepth 1 -mindepth 1 -type d | tr "\n" " "`
REPO3="$HOME/Dev/dotfiles"
STR="$REPO1 $REPO2 $REPO3"

alias chgit="check_git_status $STR"
alias chgitf="check_git_status_with_fetch $STR"
unset REPO1 REPO2 REPO3 STR
