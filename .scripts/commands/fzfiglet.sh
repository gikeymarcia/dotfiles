#!/bin/bash
# Mikey Garcia, @gikeymarcia
# interactively choose a figlet font
# dependencies: figlet fd fzf

font_dir="$HOME/.config/figlet"
opts=$(fd --maxdepth 1 -e flf . "$font_dir" | shuf )
choice=$(echo "$opts" | fzf --prompt="checkout these figlet fonts!" \
    --preview="figlet -f {} '${1:-eat sin}' | lolcat")
if [ -n "$choice" ]; then
    echo "$choice"
    figlet -f "$choice" "${1:-eat sin}"
    figlet -f "$choice" "${1:-eat sin}" | lolcat
fi
