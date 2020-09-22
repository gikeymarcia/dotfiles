#!/bin/bash
# Mikey Garcia, @gikeymarcia
# choose bookmark using dmenu and copy path to clipboard OR tmux buffer
# dependencies: dmenu bookmark-paths.sh get-clip.sh
# environment: $DMENU_FONT $DMENU_COLORS

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# shellcheck disable=SC2086
bookmark=$( bookmark-paths.sh |
            dmenu -i -l 25 $DMENU_COLORS \
                -fn "$DMENU_FONT" \
                -p "Which bookmark?" |
            awk '{ print $2 }' )

if [ -n "$bookmark" ]; then
    get-clip.sh "$bookmark"
    notify-send -t 6000 -u low -a system \
        "Bookmark filepath copied!" \
        "Paste using either the clipboard or primary selection"
fi
