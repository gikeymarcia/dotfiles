#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch OR toggle nightmode colors
#   param:  toggle  turn redshift on or off
#   param:  on      turn redshift on
# dependencies: redshift libnotify-bin

on () {
    ~/.scripts/commands/nice_shutdown.sh redshift
    notify-send -t 5000 -u normal -a system \
        -h string:x-canonical-private-synchronous:redshift_notification \
        "redshift ON" \
        "Adjusting colors for less nighttime eyestrain"
    redshift_ops="-l 34.052235:-118.243683 -t 6500:3400 -b 1.0:1.0"
    # shellcheck disable=SC2086
    redshift $redshift_ops &
}

if [ "$1" = "toggle" ]; then
    if pgrep redshift; then
        notify-send -t 3000 -u low -a system \
            -h string:x-canonical-private-synchronous:redshift_notification \
            "nightmode off" \
            "enjoy your accurate colors!"
        ~/.scripts/commands/nice_shutdown.sh redshift
    else
        on
    fi
elif [ "$1" = "on" ]; then
    on
fi
