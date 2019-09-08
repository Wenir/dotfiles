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
fi

#emacs
export EDITOR="emacsclient -t -a=\"\""
export VISUAL=$EDITOR
#see ssh wiki page
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
ssh-add ~/.ssh/id_rsa_dallahan_owerworld &> /dev/null

shopt -s checkwinsize
alias ls='ls --color=auto'
alias gtypist='gtypist --scoring=cpm'
alias mkdir='mkdir -p -v'
#aur/translate-shell
alias transv='trans -verbose'

PS1='$(CODE=$?; if [[ $CODE != 0 ]]; then echo "$CODE "; fi)\u@\H \w $(if [ -f /usr/share/git/completion/git-prompt.sh ]; then __git_ps1 "[%s]"; fi)\$ '

function up { DEEP=$1; [ -z "${DEEP}" ] && { DEEP=1; }; for i in $(seq 1 ${DEEP}); do cd ../; done; }

#vim plugin 'edkolev/promptline.vim'
if [ $TERM == "rxvt-unicode-256color" ]; then
    source ~/.promptline.sh
fi

TABLET_IP=(
    192.168.0.105
    10.9.0.3
)

for ip in "${TABLET_IP[@]}"
do
    if [ -z "${SSH_CLIENT##*$ip*}" ]; then
        source ~/.promptline.sh
    fi
done


PS1='[\u@\h \W]\$ '
