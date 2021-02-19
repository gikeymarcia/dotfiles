#!/bin/sh
# Mikey Garcia, @gikeymarcia
# downsample a video into 720p HD at a good bitrate
# dependencies: handbrake-cli

INPUT="$1"
OUTPUT="./720p--x265--21--$(basename "$1")"
HandBrakeCLI \
    --encoder x265 --encoder-preset medium --quality 21 --no-two-pass \
    --rate 30 --pfr --maxHeight 720 --maxWidth 1280 \
    -i "$INPUT" -o "$OUTPUT"
du -h "$INPUT"
du -h "$OUTPUT"

OGs=./put-back.m3u
pairs=./pairs.m3u
echo "mv -v '$OUTPUT' '$INPUT'" >> "$OGs"
echo "$OUTPUT:$INPUT" >> "$pairs"
