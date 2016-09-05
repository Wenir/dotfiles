#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# extra/pkgfile
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

# extra/git
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
    GIT=' $(__git_ps1 "[%s]")'
else
    GIT=""
fi

export EDITOR=nvim
export VISUAL=$EDITOR

shopt -s checkwinsize
alias ls='ls --color=auto'
PS1='$(CODE=$?; if [[ $CODE != 0 ]]; then echo "$CODE "; fi)\u@\H \w $GIT\$ '
