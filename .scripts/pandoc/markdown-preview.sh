#!/bin/bash
# Mikey Garcia, @gikeymarcia
# make HTML webpages from markdown documents
# optionally, pass a directory and see most recently edited file as HTML
# dependencies: pandoc fd firefox


# shellcheck disable=SC2034
# TODO monitor and rebuild vs one-time mode
# TODO when a directory is passed automatically monitor for new files

markdown="$1"
[ -d "$1" ] && markdown="$(fd -t f -e md . "$2" --changed-within 2s | head -n 1)"

pagetitle=$(basename "$markdown")
# html_preview=$(mktemp --suffix .html)
html_preview=/tmp/pandoc_conv.html
stylesheet_web=https://gist.githubusercontent.com/dashed/6714393/raw/ae966d9d0806eb1e24462d88082a0264438adc50/github-pandoc.css
stylesheet=~/.scripts/pandoc/github-pandoc.css
stylesheet=~/.scripts/pandoc/mikey-pandoc.css

if [ -r "$stylesheet" ]; then
    pandoc --metadata pagetitle="$pagetitle" -V lang=en \
        --css="$stylesheet" \
        "$markdown" --to=html5 -s -o "$html_preview"
else
    pandoc --metadata pagetitle="$pagetitle" -V lang=en \
        --css="$stylesheet_web" \
        "$markdown" --to=html5 -s -o "$html_preview"
fi

# launch preview
firefox -private "$html_preview" &
