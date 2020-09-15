#!/bin/sh
# Mikey Garcia, @gikeymarcia
# TODO why did I need this? I should see where it's actually necessary

PROGRAM=$1
if pgrep -x "$PROGRAM"; then
    killall -q "$PROGRAM"
    # Wait until processes are shut down
    while pgrep -x "$PROGRAM" >/dev/null; do sleep 1; done
else
    echo "Found no instances of ${PROGRAM} running."
fi
