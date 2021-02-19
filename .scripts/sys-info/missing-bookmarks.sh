#!/bin/bash
# Mikey Garcia, @gikeymarcia
# list all bookmark-paths.sh which aren't on the system
# dependencies: bookmark-paths.sh

bookmark-paths.sh | awk '{print $2}' | sed -E "s|^~|$HOME|" |
    xargs -I {} bash -c '[ ! -d "{}" ] && echo "{}"'
