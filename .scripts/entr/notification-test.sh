#!/bin/sh
# Mikey Garcia, @gikeymarcia
# testing out what notifications look like
# dependencies: libnotify-bin

WHEN="$(date)"
echo "fired @ $WHEN"

# normal
notify-send -u normal -t 5000  -a testing \
    "NORMAL notification" \
    "They look <b>like this</b><br>and <i>work</i> like this."
sleep 2

# low
notify-send -u low -t 5000  -a testing \
    "LOW notification" \
    "They look <b>like this</b><br>and <i>work</i> like this."
sleep 2

# critical
notify-send -u critical -t 5000  -a testing \
    "CRITICAL notification" \
    "They look <b>like this</b><br>and <i>work</i> like this."
sleep 2

# emoji
notify-send -u normal -t 5000  -a testing \
    "emoji are 🔥" \
    "They look <b>like ☯</b><br>and <i>work</i> like 🤘."
