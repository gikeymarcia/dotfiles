#!/bin/sh
# Mikey Garcia, @gikeymarcia
# script to display the status of my dotfiles repo
# accepts numeric parameter defining refresh rate (in seconds)
# default 10s refresh rate if none passed
# dependencies: git figlet lolcat
# environment: $DOTFILES


. ~/.bash_personal
cd ~ || exit 1

refresh_rate="10"
[ -n "$1" ] && refresh_rate="$1"
config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME --no-optional-locks"

while true; do
    $config branch -a
    $config branch --show-current | figlet | lolcat
    $config status -s
    sleep "$refresh_rate"
    clear
done
