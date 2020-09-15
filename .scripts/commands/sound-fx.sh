#!/bin/bash
# Mikey Garcia, @gikeymarcia
# pass a sound file and play it. Used for notifiicatons and sound boards

# TODO download and cut: buzz lightyear, the count (v), numbers
source ~/.bash_personal

killall mpg123

if [ "$1" == "random"  ]; then
    rand=$(fd . "$SOUNDS" | shuf -n 1)
    mpg123 --preframes 1 "$rand"
else
    one_of_many=$( echo "$@" | tr ' ' '\n' | shuf -n 1 )
    [ -f "$one_of_many" ] && mpg123 --preframes 1 "$one_of_many"
    # try $SOUNDS/filename
    [ ! -f "$one_of_many" ] && \
        mpg123 --preframes 1 "$SOUNDS/$(basename "$one_of_many")"
fi
