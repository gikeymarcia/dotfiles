#!/bin/sh
# Mikey Garcia, @gikeymarcia
# run launcher script called by my window managers
# dependencies: dmenu

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

## rofi
#rofi -show run

## dmenu
# shellcheck disable=SC2086
dmenu_run -i -l 8 $DMENU_COLORS \
    -fn "$DMENU_FONT" \
    -p "launcher!"
