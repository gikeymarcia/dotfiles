#!/bin/sh
# Mikey Garcia, @gikeymarcia
# select power profiles via fzf
# dependencies: fzf figlet lolcat


# TOOD can I make this not require sudo?

profiles="normal conservative long-wait no-timeout screen-off"
choice=$(printf "%s" "$profiles" | tr " " "\n" |
    fzf --no-multi --height=10 --prompt="choose a power profile -- ")

#choice="screen-off"
#printf "\nchoice:\t%s\n" "$choice"

case "$choice" in
    "normal" )
        sudo xset s 300 300
        sudo xset dpms 300 300 300
        sudo xset +dpms
        ;;
    "conservative" )
        sudo xset s 180 180
        sudo xset dpms 180 180 180
        sudo xset +dpms
        ;;
    "long-wait" )
        sudo xset s 600 600
        sudo xset dpms 600 600 600
        sudo xset +dpms
        ;;
    "no-timeout" )
        sudo xset s off
        sudo xset -dpms
        ;;
    "screen-off" )
        sudo xset +dpms
        sudo xset dpms force off
        ;;
esac

if [ -n "$choice" ] ; then
    figlet "$choice" | lolcat
    info="$(xset q)"
    standby="$(echo "$info" | grep Standby: | awk '{print $2}')"
    suspend_time="$(echo "$info" | grep Standby: | awk '{print $4}')"
    off="$(echo "$info" | grep Standby: | awk '{print $6}')"
    dpms="$(echo "$info" | grep 'DPMS is' | awk '{print $3}')"
    echo "DPMS $dpms"
    echo "Standby in $standby seconds"
    echo "Suspend in $suspend_time seconds"
    echo "Turn Off in $off seconds"
fi
