#!/usr/bin/env python
# Mikey Garcia, @gikeymarcia
# pass an alacritty yaml config and have it modified with Xresources fonts

import yaml
import subprocess
# import pprint
# pp = pprint.PrettyPrinter(indent=2, depth=3)
from sys import argv

if len(argv) < 2:
    print("USAGE: alacritty config file")
    exit(1)

alac_config = argv[1]
new_cfg = alac_config
# new_cfg = alac_config + ".conv"

# get output from from xrdb
out = subprocess.Popen(['xrdb', '-query'],
                       stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
stdout, stderr = out.communicate()
xres = [line.decode('utf-8') for line in stdout.split(b'\n')]

# parse xrdb
fontlines = [x for x in xres if "font:" in x.lower()]


def get_details(entry):
    # pass a font line from an xresources file and get back dict
    # with {"family", "style"}
    fontinfo = entry.split('\t')[1]
    family = fontinfo.split(':')[1].split("-")[0]
    style = fontinfo.split(':')[2].split('=')[1]
    return {"family": family, "style": style}


for f in fontlines:
    if "font:" in f:
        normal = get_details(f)
        size = f.split('\t')[1].split(':')[1].split("-")[1]
    elif ".italicFont:" in f:
        italic = get_details(f)
    elif ".boldFont:" in f:
        bold = get_details(f)
    elif ".bolditalicFont:" in f:
        bolditalic = get_details(f)

# read alac config
with open(alac_config) as f:
    alac_dict = yaml.load(f, yaml.FullLoader)

# format for writing to config
alacfonts = {
    'bold': bold,
    'bold_italic': bolditalic,
    'italic': italic,
    'normal': normal,
    'size': int(size),
}
alac_dict['font'] = alacfonts
# pp.pprint(alac_dict)

# write output
with open(new_cfg, "w") as f:
    yaml.dump(alac_dict, f)
