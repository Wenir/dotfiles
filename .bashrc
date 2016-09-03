#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
source /usr/share/doc/pkgfile/command-not-found.bash
export EDITOR=nvim
export VISUAL=$EDITOR

shopt -s checkwinsize
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
