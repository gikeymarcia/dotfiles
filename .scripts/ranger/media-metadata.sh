#!/bin/sh
# Mikey Garcia, @gikeymarcia
# show useful information about media files
# dependencies: mediainfo figlet

output=$( mediainfo "$1")
get_val () {
    echo "$output" | grep "^$1" | sed "s|^$1||"
}

## Extracting values
name=$(get_val "Complete name *: ")
duration=$(get_val "Duration *: " | head -n 1)
fsize=$(get_val "File size *: ")

# video
vid_bit_mode=$(get_val "Overall bit rate mode *: " | head -n 1 )
bitrate=$(get_val "Bit rate *: " | head -n 1)
framerate=$(get_val "Frame rate *: " | head -n 1)
vid_codec=$(get_val "Codec ID/Info *: " | head -n 1)
width=$(get_val "Width *: ")
height=$(get_val "Height *: ")

# audio
audio_rate=$(get_val "Bit rate *: " | tail -n 1)
audio_codec=$(get_val "Format *: " | tail -n 1)
audio_bit_mode=$(get_val "Bit rate mode *: " | tail -n 1)
channels=$(get_val "Channel(s) *: ")
speakers=$(get_val "Channel positions *: ")

## OUTPUT FORMATTING
figlet "media info"
printf "::::::::::::::::::::::::::::::::::::::::::::::::::\n"
printf "general\n"
printf "  %s\n  %s\n" "$duration" "$fsize"

printf "\nvideo\n"
printf "  %s\n" "$vid_codec"
printf "  %s x %s\n" "$width" "$height"
printf "  %s framerate\n" "$framerate"
printf "  %s %s bitrate\n" "$bitrate" "$vid_bit_mode"

printf "\naudio\n"
printf "  %s %s %s @ %s\n" "$channels" "$audio_bit_mode" "$audio_codec" "$audio_rate"
printf "  %s\n" "$speakers"
printf "\n\n%s" "$name" | sed "s ^$HOME ~ "
