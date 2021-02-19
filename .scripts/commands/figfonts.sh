#!/bin/bash
# Mikey Garcia, @gikeymarcia
# preview text in all figlet fonts on the system
# dependencies: figlet fd

font_dir=$HOME/.config/figlet
fonts=$(fd -e flf . "$font_dir" | shuf)
while IFS= read -r fig_font; do
    # preview command generating text
    printf "\n%s\n\n" "figlet -f $fig_font '${1:-eat sin}'"
    figlet -f "$fig_font" "${1:-eat sin}"
done <<< "$fonts"
