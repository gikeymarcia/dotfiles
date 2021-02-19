#!/bin/sh
# Mikey Garcia, @gikeymarcia
# dmenu selectors for alacritty font and colorscheme
# shellcheck disable=SC2086

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# make alacritty use ~/.Xresources
alac_color_script=~/.scripts/python/alacritty_xr_color_scheme.py
alac_cfg=~/.config/alacritty/alacritty.yml

# COLORSCHEMES
color_dir=~/.scripts/xcolors
color_file="$(
    cd $color_dir || exit
    fd -e xcolors . . | dmenu -i -l 8 $DMENU_COLORS -fn "$DMENU_FONT" \
                        -p 'Colorscheme: ' )"
if [ -n "$color_file" ]; then
    color_file="$color_dir/$color_file"
    if [ -f "$color_file" ]; then
        xrdb -override "$color_file"
        "$alac_color_script" "$alac_cfg"
    fi
fi
