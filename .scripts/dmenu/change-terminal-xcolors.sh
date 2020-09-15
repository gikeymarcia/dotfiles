#!/bin/sh
# Mikey Garcia, @gikeymarcia
# dmenu selectors for alacritty font and colorscheme
# shellcheck disable=SC2086

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# make alacritty use ~/.Xresources
alac_color_script=~/.scripts/alacritty/alacritty_xr_color_scheme.py
alac_font_script=~/.scripts/alacritty/alacritty_xr_font.py
alac_cfg=~/.config/alacritty/alacritty.yml

# fonts
font_dir=~/.scripts/xfonts
font_file="$(
    cd $font_dir || exit
    fd -e xfonts . . | dmenu -i -l 10 $DMENU_COLORS -fn "$DMENU_FONT" \
        -p 'Choose font: ' )"
if [ -n "$font_file" ]; then
    font_file="$font_dir/$font_file"
    if [ -f "$font_file" ]; then
        xrdb -override "$font_file"
        "$alac_font_script" "$alac_cfg"
    fi
fi

# COLORSCHEMES
color_dir=~/.scripts/xcolors
color_file="$(
    cd $color_dir || exit
    fd -e xcolors . . | dmenu -i -l 15 $DMENU_COLORS -fn "$DMENU_FONT" \
                        -p 'Choose terminal colorscheme: ' )"
if [ -n "$color_file" ]; then
    color_file="$color_dir/$color_file"
    if [ -f "$color_file" ]; then
        xrdb -override "$color_file"
        "$alac_color_script" "$alac_cfg"
    fi
fi
