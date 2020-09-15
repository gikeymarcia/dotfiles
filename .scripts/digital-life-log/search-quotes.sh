#!/bin/sh
# Mikey Garcia, @gikeymarcia
# search through $QUOTES directory in either of 2 modes
#   withOUT paramter : fzf select from quotes by filename
#   WITH paramter    : grep $QUOTES and fzf search through hits
# dependencies: fd fzf random-quote.sh fzf-preview.sh get-clip.sh

if [ -z "$1" ]; then
    found=$(
        cd "$QUOTES" || exit
        fd --color always . . | fzf --ansi --prompt="Which quote do you want? " \
                 --preview="~/.scripts/dotfiles/fzf-preview.sh '$QUOTES/{}'" )
    [ -n "$found" ] && found="$QUOTES/$found"
    ~/.scripts/commands/random-quote.sh "$found"
    ~/.scripts/commands/get-clip.sh "$found"
else
    searchterm=$1
    cd "$QUOTES" || exit
    found=$(grep -E -r "$searchterm" . | sed -E "s/^\.\/([^:]+):.*$/\1/" |
        sort | uniq | fzf --prompt="quotes containing '$searchterm':" \
        --preview="~/.scripts/dotfiles/fzf-preview.sh '$QUOTES/{}'")
    [ -n "$found" ] && found="$QUOTES/$found"
    ~/.scripts/commands/random-quote.sh "$found"
    ~/.scripts/commands/get-clip.sh "$found"
fi
