#!/bin/bash
# Mikey Garcia, @gikeymarcia
# capture output in either TMUX or clipboard
# dependencies: xclip tmux

target="$*"
echo "$target"

if [ -n "$target" ]; then
    if [ -n "$TMUX" ]; then
        tmux set-buffer "$target"
        printf "\nCaptured '%s' to tmux buffer.\n" "$target"
    elif [ -n "$DISPLAY" ]; then
        xclip -selection clipboard <(printf "%s" "$target")
        printf "\nCaptured '%s' to system clipboard.\n" "$target"
    else
        printf "Could not capture to tmux buffer or clipboard:\n%s\n" "$target"
    fi
fi
