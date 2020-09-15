#!/bin/bash
# Mikey Garcia, @gikeymarcia
# generates ranger preview views of custom file types within the $DLL
# dependencies:


wrap_len=60

item=$1
text=$(fold -s -w "$wrap_len" < "$item")

directory=$(dirname "$item")
case "$directory" in
    "$WORDS" ) directory="\$WORDS" ;;
    "$QUOTES" ) directory="\$QUOTES" ;;
esac

pr -T -o 4 <( printf "\n%s\n\n\n${directory}/%s" "$text" "$(basename "$item")")
