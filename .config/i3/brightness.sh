#!/bin/bash
source $(dirname "$0")/utils.sh
increment=10%
echo $PWD

usage="usage: $0 [-i increment] {up|down}"

while [[ $* ]]
do
    OPTIND=1
    if [[ $1 =~ ^- ]]
    then
        getopts :i: parameter
        case $parameter in
            i)
                increment="$OPTARG%"
                ;;
            *)
                echo "Invalid argument"
                echo "$usage";
                exit 1
                ;;
        esac
        shift
    else
        command=$1
    fi
    shift
done


if   [ "$command" = "up" ]; then
    xbacklight -inc $increment

elif [ "$command" = "down" ]; then
    xbacklight -dec $increment

else
    echo "$usage"
    exit 1;
fi

display_volume=$(xbacklight)

icon_name=notification-display-brightness

notify-send " " -i $icon_name -h int:value:$display_volume -h string:synchronous:volume
