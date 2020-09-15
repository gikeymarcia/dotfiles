#!/usr/bin/env bash
#
# fzf select which instances of VLC to kill

pids=$(pgrep vlc)
if [ -n "$pids" ]; then
    selection=$(printf "%s" "$pids" | xargs ps | fzf --header-lines=1 \
        --prompt="choose kill targets:  " | sed -E "s/^([0-9]+).*$/\1/g" )
    if [ -n "$selection" ]; then
        kill "$selection"
        sleep 1
        kill -KILL "$selection"
        ps "$selection"
    fi
else
    echo "no instancs of vlc found."
fi
