#!/bin/sh
# Mikey Garcia, @gikeymarcia
# fzf check zpool storage use
# dependencies: zfsutils-linux fzf

pool=$(zpool list)
datasets=$(zfs list)

clear
printf "%s\n\n" "$pool"
printf "%s" "$datasets" | head -n 1
printf "%s" "$datasets" |
    fzf --header-lines=1 --multi --prompt="Which zfs filesystem? "
printf "%s" "$datasets" | grep "/HomePool$" |
    awk '{print $3}' | sed "s ^ \n ;s|$| freespace.|"
