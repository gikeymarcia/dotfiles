#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu tool to quickly connect/disconnect to my VPN provider (nordvpn)
# dependencies: dmenu nordvpn
# environment: $DMENU_FONT $DMENU_COLORS

# TODO figure out how to get those other cities working
# shellcheck disable=SC2086

# for dmenu system defaults
source ~/.bash_env


commands+=("nordvpn disconnect")
commands+=("nordvpn connect")
# Groups
commands+=("nordvpn connect The_Americas")
commands+=("nordvpn connect Europe")
commands+=("nordvpn connect P2P")
# Countries
commands+=("nordvpn connect United_States")
commands+=("nordvpn connect Mexico")
commands+=("nordvpn connect United_Kingdom")
commands+=("nordvpn connect South_Korea")
# Cities
commands+=("nordvpn connect Los_Angeles   United_States")
commands+=("nordvpn connect San_Francisco United_States")
commands+=("nordvpn connect Dallas        United_States")
commands+=("nordvpn connect Denver        United_States")
commands+=("nordvpn connect Phoenix       United_States")
# settings
commands+=("nordvpn set technology NordLynx")
commands+=("nordvpn set technology OpenVPN")

all_commands () {
    for cmd in "${commands[@]}"; do echo "$cmd"; done
}

pull_val () {
    stem="$1"
    printf "%s" "$full_status" | grep "^$stem:" | sed -E "s/^$stem: (.*)$/\1/g"
}


full_status=$(nordvpn status)
status=$(printf "%s" "$full_status" | grep Status: | sed -E "s/^.*: (.*)$/\1/")


if [ "$status" == "Connected" ]; then
    city=$(pull_val "City")
    country=$(pull_val "Country")
    tech=$(pull_val "Current technology")
    choice=$(all_commands | dmenu -i -l 18 \
                            -p "$tech $status to $city, $country" \
                            -fn "$DMENU_FONT" $DMENU_COLORS )
    [ -n "$choice" ] && $choice
else
    choice=$(all_commands | dmenu -i -l 18 -p "VPN $status" \
                        -fn "$DMENU_FONT" $DMENU_COLORS )
    $choice
fi
