#!/bin/sh
# Mikey Garcia, @gikeymarcia
# pass a directory and get a slideshow in feh

[ -d "$1" ] && feh --auto-rotate -Z -F -z -D 12 "$1"
