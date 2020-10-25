#!/bin/bash
# Mikey Garcia, @gikeymarcia
# make HTML webpages from markdown documents
# dependencies: entr pandoc firefox markdown-preview.sh

in_doc=$1
out_doc=/tmp/pandoc-editing.html

# kill my other markdown-watch processes
my_pid=$$
pgrep --uid "$(whoami)" markdown-watch | grep -v "$my_pid" | xargs kill

# make first
markdown-preview.sh "$in_doc" "$out_doc"
firefox -private "$out_doc" &

# rebuild on each edit of input
echo "$in_doc" | entr -rpc markdown-preview.sh "$in_doc" "$out_doc"
