#!/bin/bash
# Mikey Garcia, @gikeymarcia
# fzf selector to open up and edit files added to the $DOTFILES git repo
#   if you pass the param "p" only the path to file will be captured
# dependencies: fzf figlet dotfile_paths.sh fzf_preview.sh get_clip.sh $EDITOR

figlet -f smslant edit config
choice=$( ~/.scripts/dotfiles/dotfile_paths.sh |
        fzf -i --height=85% --layout=reverse --algo=v2 \
        --preview="~/.scripts/dotfiles/fzf-preview.sh $HOME/{}" )

if [ -n "$choice" ] ; then
    # file paths
    full=$(printf "%s" "$choice" | sed "s ^ \"$HOME/ ;s $ \" " )
    oneline=$(printf "%s" "$full" | tr '\n' ' ' )
    ~/.scripts/commands/get-clip.sh "$oneline"
    [ "$1" = "p" ] && exit

    # open them up
    cd ~ || exit 1
    linecount=$(wc -l <(printf "%s\n" "$choice") | awk '{print $1}')
    if [ "$linecount" -eq 1 ]; then
        $EDITOR "$choice"
    else
        # shellcheck disable=SC2086
        $EDITOR -o $choice
    fi
else
    echo "selection cancelled."
fi
