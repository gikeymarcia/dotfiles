#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
"""
Convert an alacrity config file to support ~/.Xresources fonts

Takes alacrity config file as input and overwrites with xfont values

Adapted from https://github.com/MuntashirAkon/dotfiles/blob/master/.local/bin/alacritty_xr_color_scheme
"""

import yaml
from subprocess import run
from sys import argv
from pprint import PrettyPrinter
pp = PrettyPrinter(indent=2, compact=True).pprint

def get_val(font, size=False):
    """Parse out font information from `xrdb -query``

    Keyword arguments:
    font -- stem to look for in Xresources (see x_frmt)
    size -- when True, get font size instead of info (default False)
    """
    for line in out:
        if font in line:
            if size is True:
                return  int(line.split(':')[2].split('-')[1])
            return {
                'family': line.split(':')[2].split('-')[0],
                'style': line.split(':')[3].split('=')[1]
            }



if __name__ == '__main__':
    if len(argv) < 2:
        print("Must pass Alacritty YAML config as parameter.")
        exit(1)

    # read current Alacritty.yml configuration
    alac_config, new_cfg = argv[1], argv[1]
    with open(alac_config) as f:
        alac_dict = yaml.load(f, yaml.FullLoader)

    # get output from from xrdb
    xrdb = ['xrdb', '-query']
    out = run(xrdb, capture_output=True).stdout.decode('utf-8').split('\n')

    # create dictionary to replace alac_dict['font']
    alac_frmt = ['normal', 'italic', 'bold', 'bold_italic']
    x_frmt = ['.font:', '.italicFont:', '.boldFont:', '.bolditalicFont:']
    alac_fonts = {alac: get_val(xfnt) for alac, xfnt in zip(alac_frmt, x_frmt)}
    alac_fonts['size'] = get_val(x_frmt[0], True)

    # view (development / introspection)
    print("ORIGINAL ALACRITTY CONFIG:")
    pp(alac_dict['font'])
    print("\nCOMPUTED UPDATE FOR 'font'")
    pp(alac_fonts)

    # overwrite yml config
    #new_cfg = alac_config + ".test.yml"  # development purposes
    with open(new_cfg, "w") as f:
        alac_dict['font'] = alac_fonts
        yaml.dump(alac_dict, f)
