#!/bin/bash
# Mikey Garcia, @gikeymarcia
# make HTML webpages from markdown documents
# dependencies: pandoc

markdown="$1"
html_file=/tmp/pandoc_conv.html
[ -n "$2" ] && html_file=$2

# use local stylesheet if available
stylesheet_web=https://gist.githubusercontent.com/dashed/6714393/raw/ae966d9d0806eb1e24462d88082a0264438adc50/github-pandoc.css
stylesheet=~/.scripts/pandoc/github-pandoc.css
stylesheet=~/.scripts/pandoc/mikey-pandoc.css
css=$stylesheet_web
[ -r "$stylesheet" ] && css=$stylesheet

pagetitle=$(basename "$markdown")
pandoc --metadata pagetitle="$pagetitle" -V lang=en \
    --css="$css" --self-contained \
    "$markdown" --to=html5 -s -o "$html_file"

# TODO table of contents `--toc`

# retiring this functionality for another script
# TODO when a directory is passed automatically monitor for new files
# optionally, pass a directory and see most recently edited file as HTML
#[ -d "$1" ] && markdown="$(fd -t f -e md . "$2" --changed-within 2s | head -n 1)"
