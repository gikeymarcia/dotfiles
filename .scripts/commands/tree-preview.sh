#!/bin/sh
# Mikey Garcia, @gikeymarcia
# pass a directory and get a pretty tree preview of contents in less
# not a full listing but configured to fit my common needs
# TODO some sort of longer description mode

[ -z "$1" ] && target="$(pwd)" || target="$1"

the_tree=$(tree -C -L 2 "$target")
printf "\n%s\n\n" "tree -C -L 2 ${target}"
printf "%s" "$the_tree" | less -R
tree -C -d -L 2 "$target"
du -sh "$target"
