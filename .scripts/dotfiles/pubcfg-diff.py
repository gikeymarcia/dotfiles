#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
"""
find what's missing from public dotfiles

Finds what needs to be added to my public dotfile repo
"""

from dotfiles import Dotfiles
import os


def load_mask(mask_path):
    mask = os.path.expanduser(mask_path)
    with open(mask, 'r') as mask:
        mask = [fp for fp in mask.read().strip().split('\n')
                if fp[0] != '#']
        return mask


def plist(my_list, title="Untitled"):
    " Print list with enumerated values, and a title "
    print(f'\n{title} {len(my_list)} items')
    [print(i, val) for i, val in enumerate(my_list)]


def write_list(my_list, fpath):
    output = os.path.expanduser(fpath)
    with open(output, 'w') as out:
        [out.write(entry + '\n') for entry in my_list]


if __name__ == "__main__":
    # load masks
    private = load_mask("~/.config/filter-dotfiles/privatemask.list")
    junk = load_mask("~/.config/filter-dotfiles/junkmask.list")

    # get dotfile info
    public = Dotfiles(os.getenv('PUB_DOTFILES'))
    fulldf = Dotfiles(os.getenv('DOTFILES'))
    pub = public.get_paths()
    mine = fulldf.get_paths()

    # compute missing
    missing = [dot for dot in mine if dot not in pub]
    missing = [dot for dot in missing if dot not in private]
    missing = [dot for dot in missing if dot not in junk]
    missing = [dot for dot in missing if ".notes" not in dot]
    # compute deletes
    deletes = [dot for dot in pub if dot not in mine]

    write_list(missing, '/tmp/missing-pub')
    write_list(deletes, '/tmp/delete-pub')

    details = ("Public:\t{}\n" "Mine:\t{}\n" "Priv:\t{}\n"
               "Junk:\t{}\n" "Absent:\t{}\n")
    print(details.format(
        len(pub), len(mine), len(private), len(junk), len(missing)))

    plist(missing, 'missing @ /tmp/missing-pub')
    plist(deletes, 'deletes @ /tmp/delete-pub')

    print(' - ' * 8)
    print('Command to control public dotfiles:')
    public.show_raw()
