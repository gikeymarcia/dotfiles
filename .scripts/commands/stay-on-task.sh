#!/bin/sh
# Mikey Garcia, @gikeymarcia
# recurring reminder to keep me focused and aware of time
# pass a message and it will be displayed with each reminder

# TODO -- let the script show me when to stop
# TODO -- make running display a shout of instructions and latest timestamp

# initialize
date_form="+%H%M %U"
start=$(date "+%H%M")
interval=180
duration=0

# custom motivation message
message=$1
[ -z "$1" ] && message="keep up the good work!"

echo "BEGINNING @ $start"
while true
do
    timetable="going for $duration \n$(date "$date_form") -- $start"
    notify-send -t 7500 "$message" "$timetable" -a priority
    mpg123 -q --no-control --preframes 1 "$SOUNDS/cash-register.mp3"
    sleep "$interval"
    clear
    echo "$message" | figlet | lolcat
    now=$(date "$date_form")
    duration=$((duration + 3))
    echo "$now -- working for $duration minutes"
done
