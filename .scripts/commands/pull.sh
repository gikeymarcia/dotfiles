#!/bin/sh
# Mikey Garcia, @gikeymarcia
# search a filetree and copy a file/directory to current working directory
# dependencies: fd-find fzf
# environment:

target="$1"
[ -z "$1" ] && target="$(pwd)"

selection=$(fd . "$target" | fzf \
    --prompt="which file or directory do you want to copy here" )
[ -n "$selection" ] && [ -f "$selection" ] && cp -v --no-clobber    "$selection" .
[ -n "$selection" ] && [ -d "$selection" ] && cp -v --no-clobber -r "$selection" .
[ -z "$selection" ] && echo "selection cancelled."
