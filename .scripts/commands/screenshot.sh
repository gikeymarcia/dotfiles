#!/bin/bash
# Mikey Garcia, @gikeymarcia
# take a screenshot using GUI selector
# dependencies: flameshot
# environment: ~/.config/flameshot/capture-path

# save to path @ top of $capLoc
capLoc="$HOME/.config/flameshot/capture-path"
save_path=$(head -n 1 "$capLoc" | sed "s ^~ $HOME ")
[ ! -d "$save_path" ] && mkdir -pv "$save_path"

flameshot gui -p "$save_path"
