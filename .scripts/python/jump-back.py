#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# fzf choose parents of the current working directory
# intended for use with move-term.sh
# pip: iterfzf
import os
import sys
from iterfzf import iterfzf


def splitall(path):
    # https://www.oreilly.com/library/view/python-cookbook/0596001673/ch04s16.html
    "Splits a path into a list of it's component pieces."
    allparts = []
    while 1:
        parts = os.path.split(path)
        if parts[0] == path:  # sentinel for absolute paths
            allparts.insert(0, parts[0])
            break
        elif parts[1] == path:  # sentinel for relative paths
            allparts.insert(0, parts[1])
            break
        else:
            path = parts[0]
            allparts.insert(0, parts[1])
    return allparts


def print_2_idx(pieces, ENDex):
    "Prints splitall(path) and with seperators up to a given ENDex."
    if ENDex == 0:
        return str(pieces[0])
    else:
        str(pieces[0])
        tail = ''
        for fragment in pieces[1:ENDex+1]:
            tail = tail + str(fragment) + os.sep
        return str(pieces[0]) + tail


def subdir_dict(split_path, index):
    "Returns tuple of (depth_back, full_pathname)."
    depth_back = len(split_path) - 1 - index
    full_pathname = print_2_idx(split_path, index)
    return {"index": depth_back, "path": full_pathname}


def cwd_to_fzf_input():
    cwd = splitall(os.getcwd())
    opts = [subdir_dict(cwd, idx) for idx, val in enumerate(cwd)]
    opts.reverse()
    return (f"{o['index']} | {o['path']}" for o in opts)


if __name__ == "__main__":
    fzfriendly = cwd_to_fzf_input()
    choice = iterfzf(fzfriendly, case_sensitive=False,
                     multi=False, prompt="Jumping back to:  ")
    if choice is not None:
        jump_back = choice.split(" | ")[1:]
        print("".join(jump_back))
    else:
        print("Selection cancelled.", file=sys.stderr)
