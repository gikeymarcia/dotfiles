#!/bin/bash
# Mikey Garcia, @gikeymarcia
# TODO fix this for Ubuntu 20.04
# query deluge-console and process output into desired information
# dependencies: deluge-console


if [ -z "$1" ]; then
    INFO="$(deluge-console info)"
    SEEDING="$(grep -c Seeding <(echo "$INFO"))"
    CHECKING="$(grep -c "Checking$" <(echo "$INFO"))"
    PAUSED="$(grep -c "Paused$" <(echo "$INFO"))"
    DLS="$(grep -c Downloading <(echo "$INFO"))"
    echo "Downloading:$DLS; Seeding:$SEEDING; Paused:$PAUSED; Checking:$CHECKING"
fi

if [ "$1" == "down" ]; then
    while true;
    do
        down=$( deluge-console info | grep -B 3 -A 5 Downloading)
        linecount=$( echo "$down" | wc -l )
        date
        echo "$down"
        if [ "$linecount" -eq 1 ]; then
            echo "nothing downloading right now..."
        fi
        sleep 15 && clear
    done
fi
