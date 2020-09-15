#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch notification manager and give a tooltip with shortcuts
# dependencies: dunst libnotify-bin nice_shutdown.sh

shortcuts="<b>Ctrl+\`</b>: show last notification<br>\
<b>Ctrl+space</b>: dismiss notification<br>\
<b>Ctrl+Shift+space</b>: dismiss all notifications"

~/.scripts/commands/nice_shutdown.sh dunst
if [ ! "$1" = "off" ]; then
    dunst -conf ~/.config/dunst/dunstrc &
    notify-send -t 7500 -u normal -a system \
        "Notifications shortcuts" \
        "$shortcuts"
fi
