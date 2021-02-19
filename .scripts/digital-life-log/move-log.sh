#!/bin/sh
# Mikey Garcia, @gikeymarcia
# interactively send files or folders into digital life log
# if no parmaters are passed then open a file manager at the selected location

choice=$(
    cd "$DLL" || exit
    fd -H --type d . "$DLL" --color always|
    fzf --height=100% --ansi --prompt="move $1 ->  " --preview="fzf-preview.py {}" |
    sed "s ^log $DLL "
)
if [ -z "$choice" ]; then
    echo "action canclled."
    exit
fi

if [ -f "$1" ] && [ -n "$choice" ]; then
    mv -v "$1" "$choice"
fi

if [ -d "$1" ] && [ -n "$choice" ]; then
    mv -v -i "$1" "$choice"
fi

if [ "$1" = "p" ]; then
    printf "\n%s\n" "$choice"
fi

if [ -z "$1" ]; then
    $FILE_MANAGER --cmd="chain set sort=mtime" --cmd="set sort_reverse=False" "$choice"
fi
