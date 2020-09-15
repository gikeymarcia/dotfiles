#!/bin/bash
# Mikey Garcia, @gikeymarcia
# find paths to files/directories using fzf


# TODO let me pass parameters which will modify fd
# srch ~/.scripts -e iso ▶▶▶ fd -e iso . . | fzf
if [ -n "$1" ] ; then
    if [ -d "$1" ] ; then
        target="$1"
    elif [ -f "$1" ] ; then
        target="$(dirname "$1" )"
    else
        echo "only directories and files are acceptable parameters." && exit 1
    fi
fi
[ -z "$1" ] && target="$(pwd)"

selection=$(
    cd "$target" || exit
    fd -c always -H . . | fzf --ansi --height=80% \
        --prompt="searching in '$target' " \
        --preview="~/.scripts/dotfiles/fzf-preview.sh '$target/{}'")

# copy to clipboard
if [ -n "$selection" ]; then
    selection="$(printf '%s/%s' "$target" "$selection" | sed 's // / ')"
    ~/.scripts/commands/get-clip.sh "$selection"
else
    echo "selection canclled."
fi
