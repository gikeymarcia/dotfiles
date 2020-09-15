#!/bin/sh
# Mikey Garcia, @gikeymarcia
# dmenu select a bookmark path and open in terminal file manager

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# shellcheck disable=SC2086
BOOKMARK_PATH=$(bookmark_paths.sh |
                dmenu -i -l 25 $DMENU_COLORS \
                    -fn "$DMENU_FONT" \
                    -p "Which bookmark?" |
                awk '{ print $2 }' | sed "s ^~ $HOME "
)
if [ -n "$BOOKMARK_PATH" ]; then
    if [ -d "$BOOKMARK_PATH" ]; then
        $TERMINAL \
            --working-directory "$(echo "$BOOKMARK_PATH" | tr -d '\n' )" \
            -e $FILE_MANAGER
    else
        notify-send -t 6000 -u normal -a system \
            "Directory not on this machine" \
            "<b>${BOOKMARK_PATH}</b><br>is not a directory on this machine"
    fi
fi
