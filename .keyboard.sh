#!/usr/bin/env bash

XKB_DIR="$HOME/.config/xkb"
XKB_SYMBOL_FILE="custom"
# hostname binary with path
HOSTN=$(which hostname)
# grep binary with path
GREPPR=$(which grep)

HOST=""
XKB_ADDON=""
if [ -n "$HOSTN" ];
then
    HOST=$($HOSTN -f)
    if [[ -n $HOST && -n "$($GREPPR $HOST $XKB_DIR/symbols/$XKB_SYMBOL_FILE)" ]]; then
        XKB_ADDON="+$XKB_SYMBOL_FILE($HOST)"
    fi
fi

if [[ -n $(which setxkbmap) && -n $(which xkbcomp) ]];
then
    setxkbmap -layout "$XKB_SYMBOL_FILE(my_us)$XKB_ADDON,$XKB_SYMBOL_FILE(my_ru)" \
    -option "" -option "" -print \
    | xkbcomp -I"$XKB_DIR" - "${DISPLAY%%.*}" # >/dev/null 2>&1
fi
