#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
"""
Convert an alacrity config file to support ~/.Xresources color schemes

Takes alacrity config file as input and overwrites with xcolor values

from https://github.com/MuntashirAkon/dotfiles/blob/master/.local/bin/alacritty_xr_color_scheme
modifications by @gikeymarcia
"""

from sys import argv
import subprocess
import yaml

if len(argv) < 2:
    print("Must pass Alacritty YAML config as parameter.")
    exit(1)

fname, fout_name = argv[1], argv[1]
# fout_name = fname + ".conv"  # for development puprposes

xrdb = ['xrdb', '-query']
out = subprocess.run(xrdb, capture_output=True).stdout.decode('utf-8')


def get_color(query):
    " Takes an xrdb color name and returns it's hex value "
    for line in out.splitlines():
        if query in line:
            return '#' + line.split('#')[1]


colors = {
    "primary": {
        "background": get_color('background'),
        "foreground": get_color('foreground')
    },
    "normal": {
        "black": get_color('color0'),
        "red": get_color('color1'),
        "green": get_color('color2'),
        "yellow": get_color('color3'),
        "blue": get_color('color4'),
        "magenta": get_color('color5'),
        "cyan": get_color('color6'),
        "white": get_color('color7')
    },
    "bright": {
        "black": get_color('color8'),
        "red": get_color('color9'),
        "green": get_color('color10'),
        "yellow": get_color('color11'),
        "blue": get_color('color12'),
        "magenta": get_color('color13'),
        "cyan": get_color('color14'),
        "white": get_color('color15')
    }
}

with open(fname) as f:
    al_dict = yaml.load(f, yaml.FullLoader)
    al_dict['colors'] = colors
    with open(fout_name, "w") as f:
        yaml.dump(al_dict, f)
