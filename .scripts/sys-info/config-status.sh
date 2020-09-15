#!/bin/sh
# Mikey Garcia, @gikeymarcia
# script to display the status of my dotfiles repo
# accepts numeric parameter defining refresh rate (in seconds)
# default 10s refresh rate if none passed
# dependencies: $DOTFILES git figlet lolcat


. ~/.bash_personal
cd ~ || exit 1

REFRESH_RATE="10"
[ -n "$1" ] && REFRESH_RATE="$1"

config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME --no-optional-locks"
export config

while true
do
    $config branch -a
    $config branch --show-current | figlet | lolcat
    $config status -s

    sleep "$REFRESH_RATE"
    clear
done
