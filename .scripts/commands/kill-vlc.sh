#!/usr/bin/env bash
# Mikey Garcia, @gikeymarcia
# fzf select which instances of VLC to kill
# dependencies: fzf
# TODO use xargs and let the script kill more than one instance at a time

pids=$(pgrep vlc)
if [ -n "$pids" ]; then
    selection=$(printf "%s" "$pids" | xargs ps | fzf --header-lines=1 \
        --prompt="choose kill targets:  " | sed -E "s/^ ?([0-9]+).*$/\1/g" )
    if [ -n "$selection" ]; then
        kill "$selection"
        sleep 1
        kill -KILL "$selection"
        ps "$selection"
    fi
else
    echo "no instancs of vlc found."
fi
