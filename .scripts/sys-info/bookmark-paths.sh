#!/bin/sh
# Mikey Garcia, @gikeymarcia
# remove comments and empty lines from bookmarks file
# dependencies:

sed '/^#.*$/d;/^$/d' ~/.config/bookmarks-dirs.dirs
