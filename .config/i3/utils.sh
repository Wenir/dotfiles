function start
{
    mkdir -p /tmp/$USER/$0/

    if [ $(ls -1 /tmp/$USER/$0 | wc -l) -gt 0 ]; then
        exit 2
    fi

    trap quit EXIT
    touch /tmp/$USER/$0/$$
}

function quit
{
    rm -f /tmp/$USER/$0/$$
}
#start
