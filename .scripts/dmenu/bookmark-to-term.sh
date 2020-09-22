#!/bin/sh
# Mikey Garcia, @gikeymarcia
# dmenu select a bookmark path and open in terminal file manager
# dependencies: dmenu libnotify-bin bookmark-paths.sh
# environment: $DMENU_COLORS $DMENU_FONT $FILE_MANAGER $TERMINAL

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# shellcheck disable=SC2086
bookmark=$(bookmark-paths.sh |
                dmenu -i -l 25 $DMENU_COLORS \
                    -fn "$DMENU_FONT" \
                    -p "Which bookmark?" |
                awk '{print $2}' | sed "s ^~ $HOME "
)
if [ -n "$bookmark" ]; then
    if [ -d "$bookmark" ]; then
        $TERMINAL --title "$bookmark" -e $FILE_MANAGER "$bookmark"
    else
        notify-send -t 6000 -u normal -a system \
            "Directory not on this machine" \
            "<b>${bookmark}</b><br>is not a directory on this machine"
    fi
fi
