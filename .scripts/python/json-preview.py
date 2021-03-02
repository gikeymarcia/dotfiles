#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# dependencies: jq
import json
from sys import argv
from subprocess import run

filename = argv[1]

with open(filename, 'r') as fp:
    data = json.load(fp)

if filename[-9:] == 'info.json':
    sel = [
        'id', 'uploader', 'title', 'webpage_url', 'channel_url',
        'description', 'duration', ]
    for s in sel:
        print(f"{s}: {data.get(s)}")
else:
    run(['jq', '-C', '.', filename])
