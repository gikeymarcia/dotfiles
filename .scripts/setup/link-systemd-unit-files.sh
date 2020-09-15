#!/bin/bash
# Mikey Garcia, @gikeymarcia
# install systemd unit files (which exist in $HOME)
# dependencies:

sysd=/lib/systemd/system
localunit=~/.system-files/systemd-unit-files
link_to_systemd () {
    name="$(basename "$1")"
    if [ -f "$1" ]; then
        sudo ln -v -s -i "$1" "$sysd/$name"
    fi
}
link_to_systemd  "$localunit/clipmenud.service"
link_to_systemd  "$localunit/function-first.service"
#link_to_systemd  "$localunit/deluged.service"
#link_to_systemd  "$localunit/deluge-web.service"

sudo systemctl daemon-reload
