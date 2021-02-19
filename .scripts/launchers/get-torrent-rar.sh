#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dependencies: unrar fd fzf

seeding_dir=/Torrents/seeding

selection=$(
    cd "$seeding_dir" || exit
    fd -e rar . . |
        fzf -i --height=30 --layout=reverse --prompt="which rar path? "
    )

if [ -n "$selection" ]; then
    selections=$(printf "%s" "$selection" | sed "s|^|$seeding_dir/|g")
    echo "$selections" | xargs -I {} unrar e "{}"
    echo "$selections"
fi
