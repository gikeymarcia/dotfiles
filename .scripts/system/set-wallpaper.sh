#!/bin/bash
# Mikey Garcia, @gikeymarcia
# randomize, choose, or manualy specficy desktop wallpaper
# dependencies: sxiv feh fd
# environment: $WALLPAPERS

# TODO: cleanup and add PAUSE to stop shuffling, notification /tmp/wallfreeze
. ~/.bash_personal
freeze=/tmp/freeze-wallpaper

[ ! -d "$WALLPAPERS" ] && echo "$WALLPAPERS is not a directory"

# pick randomly
if [ -z "$1" ]; then
    if [ ! -f "$freeze" ]; then
        rand=$(fd -e jpg -e png -e jpeg --max-depth 1 . "$WALLPAPERS" | shuf -n 1)
        feh --no-fehbg --bg-fill "$rand" "$rand"
    fi
fi

function set_bg () {
    feh --no-fehbg --bg-fill "$1" "$1"
}

# set manually or try in $WALLPAPERS directory
if [ -f "$1" ]; then
    set_bg "$1"
else
    try="$WALLPAPERS/$(basename "$1")"
    [ -f "$try" ] && set_bg "$try"
fi

# shellcheck disable=SC2046
if [ "$1" = "choose" ]; then
    choice=$(sxiv -t -o -N "choose your wallpaper" \
            $(fd -d 1 -e jpg -e jpeg -e png . "$WALLPAPERS" | shuf))
    [ -n "$choice" ] && set_bg "$choice"
elif [ "$1" = "stop" ]; then
    if [ -f "$freeze" ]; then
        notify-send "Resuming Wallpaper cycling" "Freeze with C-S-Mod4-W"
        rm "$freeze"
    else
        notify-send "WALLPAPER FREEZE!" "Stopping background auto-rotate. Re-enable with C-S-Mod4-W"
        touch "$freeze"
    fi
fi

# when using cron make sure to export display ($ env | grep -i display) e.g.,
# */20 * * * * env DISPLAY=:0 /home/mikey/.scripts/system/set-wallpaper.sh
