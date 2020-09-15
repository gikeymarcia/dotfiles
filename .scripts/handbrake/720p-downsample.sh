#!/bin/sh
# Mikey Garcia, @gikeymarcia
# downsample a video into 720p HD at a good bitrate
# dependencies: handbrake-cli

INPUT="$1"
OUTPUT="$2"
HandBrakeCLI \
    --encoder x264 --x264-preset medium --x264-profile high --x264-tune film \
    --quality 19 --two-pass --turbo \
    --rate 29.97 --maxHeight 720 --maxWidth 1280 \
    -i "$INPUT" -o "$OUTPUT"
