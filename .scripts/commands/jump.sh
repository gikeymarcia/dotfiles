#!/bin/sh
# Mikey Garcia, @gikeymarcia
# list child directories from current location (or param) and cd to them
# dependencies: fd fzf tree fzf-preview.sh

if [ -z "$1" ]; then
    target="$(pwd)"
else
    target="$1"
fi

selection=$(
    cd "$target" || exit
    fd -H -t d --color always . . | fzf --ansi +m \
        --preview="fzf-preview.sh $target/{}"
)
if [ -n "$selection" ]; then
    selection="$target/$selection"
    cd "$selection" || exit
    clear
    tree -L 2 .
    ls -lht -c --color=always
    printf "%s\n" "$selection"
    du -sh .
else
    printf "%s\n" "selection cancelled"
fi
