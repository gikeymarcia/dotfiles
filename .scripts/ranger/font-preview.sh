#!/bin/sh
# Mikey Garcia, @gikeymarcia
# font file preview with useful preconfigured strings
# dependencies: lcdf-typetools

font_size=13

# the pieces
output=$(otfinfo --info "$1")
font_family=$(echo "$output" | grep ^Family: | sed "s/^Family:\s*//")
font_style=$(echo "$output" | grep ^Subfamily: | sed "s/^Subfamily:\s*//")

# pretty printing
echo "$1" | sed "s ^$HOME/.fonts/  "
echo "$font_family"
echo "$font_style"

figlet -f slant "Xres"
echo "xft:$font_family-$font_size:style=$font_style:antialias=true:hinting=true"

figlet -f slant "dmenu"
echo "$font_family-$font_size:style=$font_style:antialias=true:hinting=true"

figlet -f slant "xft"
echo "xft:$font_family-$font_size:style=$font_style:antialias=true:hinting=true"
