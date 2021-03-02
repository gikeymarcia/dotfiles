#!/bin/bash
# Mikey Garcia, @gikeymarcia
# make HTML webpages from markdown documents
# updates the HTML preview file each time the file is edited
# dependencies: entr pandoc markdown-preview.sh
# environment: $BROWSER

in_doc=$1
out_doc=/tmp/pandoc-editing.html
# Temp band-aid b/c brave doesn't activate vimium
BROWSER="firefox -private -new-window"

# kill my other markdown-watch processes
my_pid=$$
pgrep --uid "$(whoami)" -f markdown-preview.sh | grep -v "$my_pid" |
    xargs --no-run-if-empty kill

# make first
markdown-preview.sh "$in_doc" "$out_doc"
$BROWSER "$out_doc" &

# rebuild on each edit of input
echo "$in_doc" | entr -rpc markdown-preview.sh "$in_doc" "$out_doc"
