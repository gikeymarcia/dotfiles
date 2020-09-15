#!/bin/sh
# Mikey Garcia, @gikeymarcia
# INCOMPLETE: turn bookmarks file into ranger bookmarks
# dependencies: bookmark_paths.sh


# TODO: figure out multi-letter stem -> ranger bookmarks
~/.scripts/sys-info/bookmark_paths.sh |
    sed -e "s/ \+/:/" | sed "s :~ :$HOME "  > ~/.config/ranger/bookmarks
