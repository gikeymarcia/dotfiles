#!/bin/bash
# Mikey Garcia, @gikeymarcia
# quick selector to view markdown notes as html webpages
# dependencies: rofi pandoc markdown-preview.sh
# environment:

# choose markdown file
notes_dir="$HOME/.notes"
cd "$notes_dir" || exit
md_stub=$(fd -e md .  | shuf | rofi -dmenu -l 20 -i -p "notes!")

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

# notes: previously used $BROWSER but after switching to brave-browser I
# found it didnt work as well for me as firefox so switched this script
# back to firefox
