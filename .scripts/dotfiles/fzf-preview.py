#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# preview fzf selections
# dependencies: media-info.py random-quote.sh
#               bat lcdf-typetools poppler-utils jq figlet
#               genisoimage

import sys
import os
import subprocess
from shutil import which


def preview_file(path):
    # lookup file extension and generate correct preview
    ext = path.split(".")[-1]
    extensions = {
        'mp3': media_func,
        'mkv': media_func,
        'mp4': media_func,
        'webm': media_func,
        'flf': figlet_func,
        'quote': lambda p: subprocess.run(['random-quote.sh', p]),
        'pdf': lambda p: subprocess.run(['pdftotext', p, '-']),
        'deb': lambda p: subprocess.run(['dpkg-deb', '--info', p]),
        'iso': lambda p: subprocess.run(['isoinfo', '-d', '-i', p]),
        'ttf': lambda p: subprocess.run(['otfinfo', '--info', p]),
        'cow': lambda p: subprocess.run(['cowsay', '-f', p, 'Moooo!']),
        'json': lambda p: subprocess.run(['jq', '.', p]),
    }
    if ext in extensions.keys():
        action = extensions[ext]
        action(path) if callable(action) else print(action)
    else:
        cmd = ['bat', '--color', 'always', '--wrap',
               'never', '--terminal-width', '-2', path]
        subprocess.run(cmd)


def media_func(path):
    # preview for media files
    cmd = [os.path.expanduser('~/.scripts/python/media-info.py'), path]
    subprocess.run(cmd)


def figlet_func(path):
    # special preview for figlet font files
    subprocess.run(['figlet', '-f', path, "eat sin"])
    subprocess.run(['figlet', '-f', path, "EAT SIN"])
    subprocess.run(['figlet', '-f', path, "{}".format(os.path.basename(path))])


# main logic
if len(sys.argv) > 1:
    path = str(sys.argv[1])
    if len(sys.argv) == 2:
        searches = None
    else:
        searches = sys.argv[2:]
        for s in searches:
            subprocess.run(['grep', '-n', s, path])
    if os.path.isfile(path):
        preview_file(path)
    elif os.path.isdir(path):
        subprocess.run(['ls', '--color=always', '-c',
                        '--group-directories-first', '-F', path])
    else:
        if which('figlet'):
            subprocess.run(['figlet', 'fzf preview'])
        else:
            print('fzf-preview: sys.argv below')
            [print(f'{i}\t{arg}') for i, arg in enumerate(sys.argv)]
