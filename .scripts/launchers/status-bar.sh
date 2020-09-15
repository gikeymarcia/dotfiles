#!/bin/sh
# Mikey Garcia, @gikeymarcia
# control polybar status bar
#   param: toggle
#   param: *        restart polybar
# dependencies: polybar nice_shutdown.sh


launch_status_bar () {
    polybar laptop > /dev/null &
}

if [ "$1" = "toggle" ]; then
    if pgrep polybar; then
        ~/.scripts/commands/nice_shutdown.sh polybar
    else
        launch_status_bar
    fi
else
    ~/.scripts/commands/nice_shutdown.sh polybar
    launch_status_bar
fi
