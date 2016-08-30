#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
source /usr/share/doc/pkgfile/command-not-found.bash

shopt -s checkwinsize
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
