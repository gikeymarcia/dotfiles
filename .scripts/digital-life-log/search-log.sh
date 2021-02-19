#!/bin/sh
# Mikey Garcia, @gikeymarcia
# search lifelog with fzf and change action based on selection
# open directoryies in ranger, edit certain filetypes, and show path for all
# dependencies: fd fzf ranger zathura get-clip.sh $EDITOR

# TODO grep through log for terms (ripgrep??)
# rg --files-with-matches -t md meditation | fzf --preview="bat {}"
choice=$(
    cd "$DLL" || exit
    fd -H -t f -t d --color always . . |
        fzf --height=100% --ansi --prompt="searching digitial life log... " \
        --preview='~/.scripts/dotfiles/fzf-preview.py {}'
)


if [ -n "$choice" ]; then
    choice="$DLL/$choice"
    # grab selection
    ~/.scripts/commands/get-clip.sh "$choice"
    if [ -d "$choice" ]; then
        ranger "$choice" \
            --cmd="chain set sort=mtime" \
            --cmd="set sort_reverse=False"
    else
        case "$choice" in
            *.md|*.sh|*.sangha|*.quote)
                $EDITOR "$choice" ;;
            *.pdf )
                zathura "$choice" ;;
        esac
    fi
fi
