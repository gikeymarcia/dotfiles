#!/bin/bash
# Mikey Garcia, @gikeymarcia

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# shellcheck disable=SC2086
bookmark=$( ~/.scripts/sys-info/bookmark_paths.sh |
            dmenu -i -l 25 $DMENU_COLORS \
                -fn "$DMENU_FONT" \
                -p "Which bookmark?" |
            awk '{ print $2 }' )

if [ -n "$bookmark" ]; then
    ~/.scripts/commands/get-clip.sh "$bookmark"

    notify-send -t 6000 -u low -a sys \
        "Bookmark filepath copied!" \
        "Paste using either the clipboard or primary selection"
fi
