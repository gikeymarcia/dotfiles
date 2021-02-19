#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu quick selector for my markdown notes
#   selected item gets turned into html file and opened in $BROWSER
# dependencies: dmenu pandoc markdown-preview.sh
# environment: $DMENU_FONT $DMENU_COLORS $BROWSER
# shellcheck disable=SC2086

# choose markdown file
notes_dir="$HOME/.notes"
cd "$notes_dir" || exit
md_stub=$(fd -e md .  | shuf |
           dmenu -l 20 -i -fn "$DMENU_FONT" $DMENU_COLORS -p "notes!")

# generate preview
html_dir="$HOME/.cache/my-notes"
if [ -n "$md_stub" ]; then
    echo "$md_stub"
    fname=$(basename "$md_stub" .md)
    subdir=$(dirname "$md_stub")
    html_path="$html_dir/$subdir/${fname}.html"
    markdown-preview.sh "$md_stub" "$html_path"
    file "$html_path"
    ls -lh "$html_path"
    firefox -private -new-window "$html_path" &
fi
