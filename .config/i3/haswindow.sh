xprop -root                              |
grep '_NET_CLIENT_LIST_STACKING(WINDOW)' |
grep -ohw 0x.......                      |
while read line;
do
    xprop -id "$line";
done                                     |
grep WM_CLASS                            |
grep $1
