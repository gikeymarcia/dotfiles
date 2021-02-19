#!/bin/bash
# Mikey Garcia, @gikeymarcia
# make HTML webpages from markdown documents
# dependencies: pandoc
# $1 = markdown_input   e.g., my-notes.md
# $2 = html_outpath     e.g., notes.html

markdown=$1
cd "$(dirname "$markdown")" || exit
markdown="$(basename "$markdown")"

if [ -z "$2" ]; then
    html_file=/tmp/pandoc_conv.html
else
    html_file=$2
fi


# see styles with `pandoc --list-highlight-styles`
hilight=tango   # pygments,espresso,zenburn,kate,monochrome,breezedark,haddock

#css="https://gist.githubusercontent.com/dashed/6714393/raw/ae966d9d0806eb1e24462d88082a0264438adc50/github-pandoc.css"
css="$HOME/.scripts/pandoc/gikeymarcia.css"

pagetitle=$(basename "$markdown")
pandoc --metadata pagetitle="$pagetitle" -V lang=en \
    --self-contained --standalone  --mathjax \
    --css="$css" --highlight-style="$hilight" \
    "$markdown" --from=markdown+implicit_header_references+task_lists \
    --to=html5 -o "$html_file"
