#!/bin/sh
# Mikey Garcia, @gikeymarcia
# dmenu launcher of chat programs

# list to choose from
OPTIONS="telegram-desktop slack whatsapp signal-desktop yakyak discord"

# shellcheck disable=SC2086
CHOICE=$(echo "$OPTIONS" | tr " " "\n" |
        dmenu -l 5 $DMENU_COLORS \
            -fn "$DMENU_FONT" \
            -p "Which chat application?"
)

# launch selected application
case "$CHOICE" in
    "whatsapp" )
        brave-browser --app=https://web.whatsapp.com/
    ;;
    * )
        [ -n "$CHOICE" ] && "$CHOICE"
    ;;
esac
