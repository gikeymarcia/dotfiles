#!/bin/sh
# Mikey Garcia, @gikeymarcia
# INCOMPLETE: turn bookmarks file into ranger bookmarks
# dependencies: bookmark-paths.sh


# TODO: figure out multi-letter stem -> ranger bookmarks
bookmark-paths.sh |
    sed -e "s/ \+/:/" | sed "s :~ :$HOME "  > ~/.config/ranger/bookmarks
