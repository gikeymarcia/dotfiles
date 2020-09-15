#!/bin/bash
# Mikey Garcia, @gikeymarcia
# control clipmenu clipboard manager
#   param: on, off, * = toggle

# shellcheck disable=SC2086,SC1090
# https://serverfault.com/questions/413397/how-to-set-environment-variable-in-systemd-service

on () {
    clipctl enable
    printf "%s" "on" > /tmp/clipman
    notify-send -t 5000 -a clipmenu \
        -h string:x-canonical-private-synchronous:clipmenu \
        "saving clipboard history" &

}

off () {
    clipctl disable
    printf "%s" "off" > /tmp/clipman
    notify-send -t 5000 -a clipmenu \
        -h string:x-canonical-private-synchronous:clipmenu \
        "DISABLE clipboard history" &

}

case "$1" in
    "on" ) on ;;
    "off" ) off ;;
    "choose" )
        source ~/.bash_env
        clipmenu -i -l 20 $DMENU_COLORS \
            -fn "$DMENU_FONT"
    ;;
    * )
        if [ "$(cat /tmp/clipman)" = "on" ]; then
            off
        else
            on
        fi
    ;;
esac
