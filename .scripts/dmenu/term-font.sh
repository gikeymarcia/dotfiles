#!/bin/sh
# Mikey Garcia, @gikeymarcia
# dmenu selectors for alacritty font and colorscheme
# shellcheck disable=SC2086

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

# make alacritty use ~/.Xresources
alac_font_script=~/.scripts/python/alacritty_xr_font.py
alac_cfg=~/.config/alacritty/alacritty.yml

# fonts
font_dir=~/.scripts/xfonts
font_file="$(
    cd $font_dir || exit
    fd -e xfonts . . | dmenu -i -l 20 $DMENU_COLORS -fn "$DMENU_FONT" \
        -p 'Font: ' )"
if [ -n "$font_file" ]; then
    font_file="$font_dir/$font_file"
    if [ -f "$font_file" ]; then
        xrdb -override "$font_file"
        "$alac_font_script" "$alac_cfg"
    fi
fi
