#!/bin/bash
# Mikey Garcia, @gikeymarcia
# pipe into this function and fzf select

# https://superuser.com/questions/747884/how-to-write-a-script-that-accepts-input-from-a-file-or-from-stdin

[ "$#" -ge 1 ] && [ -f "$1" ] && input="$1"
[ -z "$1" ] && input="-"
choice=$(cat "$input" | fzf)
if [ -n "$choice" ]; then
    ~/.scripts/commands/get-clip.sh "$choice"
elif [ -z "$choice" ]; then
    echo "selection cancelled."
fi
