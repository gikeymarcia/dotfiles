#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dependencies: unrar fd fzf

seeding_dir=~/Torrents/seeding

selection=$(
    cd $seeding_dir || exit
    fd -e rar . . | fzf -i --height=30 --layout=reverse \
                    --prompt="which rar path? " )

if [ -n "$selection" ]; then
    selection="$seeding_dir/$selection"
    # grab unrar command
    open_cmd=" unrar e '$selection'"
    ~/.scripts/commands/get-clip.sh "$open_cmd"
    printf "%s\n%s\n" "$open_cmd" "$selection"
fi
