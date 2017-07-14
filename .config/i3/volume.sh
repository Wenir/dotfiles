#!/bin/bash
source $(dirname "$0")/utils.sh
increment=2%

usage="usage: $0 [-i increment] {up|down|mute}"

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

sink=$(
    pactl list sinks |
    sed -n 1p        |
    grep -o "[0-9]"
)

if   [ "$command" = "up" ]; then
    pactl set-sink-volume $sink +$increment

elif [ "$command" = "down" ]; then
    pactl set-sink-volume $sink -$increment

elif [ "$command" = "mute" ]; then
    pactl set-sink-mute $sink toggle

else
    echo "$usage"
    exit 1
fi

display_volume=$(
    pactl list sinks         |
    grep Volume              |
    grep -o " [0-9]\{1,3\}%" |
    sed -n 1p                |
    grep -o "[0-9]*"
)

icon_name=""

pactl list sinks | grep Mute | grep -q yes

if [ $? -eq 0 ]; then

    display_volume=0
    icon_name="notification-audio-volume-muted"

elif [ "$icon_name" = "" ]; then

    if   [ "$display_volume" -eq  "0" ]; then
        icon_name="notification-audio-volume-off"

    elif [ "$display_volume" -lt "33" ]; then
        icon_name="notification-audio-volume-low"

    elif [ "$display_volume" -lt "67" ]; then
        icon_name="notification-audio-volume-medium"

    else
        icon_name="notification-audio-volume-high"

    fi

fi
notify-send " " -i $icon_name -h int:value:$display_volume -h string:synchronous:volume


