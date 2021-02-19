#!/bin/bash
# Mikey Garcia, @gikeymarcia
vlc $(fd -t f -e mp4 -e avi -e mkv -e webm . . | shuf) 2> /dev/null
