#!/bin/bash
# Mikey Garcia, @gikeymarcia
# run launcher script called by my window managers
# dependencies: dmenu rofi

# shellcheck source=/home/mikey/.bash_env
source ~/.bash_env

# rofi
rofi -modi "run,drun,ssh" -show run

## dmenu
## shellcheck disable=SC2086
# dmenu_run -i -l 8 $DMENU_COLORS \
#     -fn "$DMENU_FONT" \
#     -p "launcher!"
