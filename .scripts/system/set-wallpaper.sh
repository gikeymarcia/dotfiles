#!/bin/sh
# Mikey Garcia, @gikeymarcia
# randomize, choose, or manualy specficy desktop wallpaper
# dependencies: sxiv feh fd


# try alternate location
[ ! -d "$WALLPAPERS" ] && WALLPAPERS=~/local-library/pictures/wallpapers

# pick randomly
[ -z "$1" ] && feh --no-fehbg --bg-fill --randomize "$WALLPAPERS"

set_bg() {
    feh --no-fehbg --bg-fill "$1"
}

# set manually or try in $WALLPAPERS directory
if [ -f "$1" ]; then set_bg "$1"
else
    try="$WALLPAPERS/$(basename "$1")"
    [ -f "$try" ] && set_bg "$try"
fi

# shellcheck disable=SC2046
if [ "$1" = "choose" ]; then
    echo choose.
    choice=$(sxiv -t -o -N "choose your wallpaper" \
            $(fd -d 1 -e jpg -e jpeg -e png . "$WALLPAPERS" | shuf))
    [ -n "$choice" ] && set_bg "$choice"
fi

# when using cron make sure to export display ($ env | grep -i display) e.g.,
# */10 * * * * env DISPLAY=:0 /home/mikey/.scripts/system/set-wallpaper.sh
