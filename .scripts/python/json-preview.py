#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
import mikey  # noqa: F401
import json
# import os
import sys
# from pprint import pprint

filename = sys.argv[1]

with open(filename, 'r') as fp:
    data = json.load(fp)

# keys = [print(k) for k in data]

sel = [
    'id',
    'uploader',
    'title',
    'url',
    'channel_url',
    'description',
    'duration',
]

for s in sel:
    print(f"{s}: {data.get(s)}")
