#!/bin/bash
# Mikey Garcia, @gikeymarcia
# fzf select and launch jupyter notebooks running on the machine
# dependencies: fzf jupyter firefox

sel=$(jupyter notebook list | fzf --prompt="open notebooks:" --header-lines=1 |
    tee /dev/tty | awk '{print $1}')
[ -n "$sel" ] && firefox -private "$sel"
