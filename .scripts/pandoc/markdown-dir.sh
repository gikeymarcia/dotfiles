#!/bin/bash
# Mikey Garcia, @gikeymarcia
# watch directory for changing markdown files
# dependencies: pandoc markdown-preview.sh entr fd
# environment: $BROWSER
# TODO not working yet -- fix

live_preview=/tmp/pandoc_dir.html
if [ -d "$1" ]; then
    cd "$1" || exit
    markdown-preview.sh "$(fd -t f -e md . "$1" | shuf -n 1)" "$live_preview"
    $BROWSER "$live_preview"
    fd -t f -e md . "$1" |
        entr -rpc markdown-preview.sh \
            "$(fd -t f -e md . "$1" --changed-within 2s | head -n 1)" \
            "$live_preview"
fi
