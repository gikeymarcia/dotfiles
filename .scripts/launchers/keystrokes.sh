#!/bin/sh
# Mikey Garcia, @gikeymarcia
# toggles screenkey on with my desired settings
# dependencies: screenkey nice_shutdown.sh
# TODO get back customization and install screenkey from github


repo_bin=~/Documents/git_repos/screenkey/screenkey
if pgrep -f screenkey; then
    pgrep -f screenkey | xargs kill
    notify-send -a system -u normal -t 1750 "screenkey off" "party on"
else
    $repo_bin
fi
exit
# notes: https://gitlab.com/wavexx/screenkey/blob/master/README.rst

# TODO this script is not working in 20.04
# next-step install from source
# https://www.thregr.org/~wavexx/software/screenkey/
if pgrep screenkey -u "$USER"; then
    ~/.scripts/commands/nice_shutdown.sh screenkey
    notify-send -a system -u low -t 750 "<b>screenkey off</b>" "party on"
else
    case "$1" in
        "set" )     window_position="957x205+1592+1250"
        ;;
        "choose" )  window_position=$(slop -n -f '%g')
        ;;
    esac
    echo "$window_position" > /tmp/screenkey-pos
    "$repo_bin" -g "$window_position" --position fixed \
        --timeout 2.0 --persist --compr-cnt 2 \
        --font "Hack Nerd Font Mono" --font-size small \
        --bg-color "#005fd7" --font-color "#c5c8c6" \
        --key-mode translated --bak-mode baked \
        --opacity 0.65
fi
# notes: https://gitlab.com/wavexx/screenkey/blob/master/README.rst
