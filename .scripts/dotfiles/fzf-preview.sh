#!/bin/bash
# Mikey Garcia, @gikeymarcia
# script called by fzf --preview="" to intelligently preview selections
# dependencies: bat figlet poppler-utils media-metadata.sh random-quote.sh

# IDEA -- maybe this should be a python3 script

get_extension(){
   echo "this is the future."
    # TODO make this script return filetype extension then use
    # a case statement to determine which preview to display
    # seems cleaner and easier to maintain.
}

if [ -d "$1" ]; then
    ls --color=always -c --group-directories-first -F "$1"
elif [ "${1: -4}" == ".mp3" ]; then
    ~/.scripts/ranger/media-metadata.sh "$1"
elif [ "${1: -6}" == ".quote" ]; then
    ~/.scripts/commands/random-quote.sh "$1"
elif [ "${1: -4}" == ".pdf" ]; then
    pdftotext "$1" -
elif [ "${1: -4}" == ".deb" ]; then
    dpkg-deb --info "$1"
elif [ "${1: -4}" == ".cow" ]; then
    echo "howdy! I am a cow file" | cowsay -f "$(basename "$1")"
elif [ -f "$1" ]; then
    bat --color always --wrap auto --terminal-width 80 "$1"
else
    figlet "fzf preview"
fi
