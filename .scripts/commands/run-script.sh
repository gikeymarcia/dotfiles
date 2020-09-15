#!/bin/bash
# Mikey Garcia, @gikeymarcia
# Run executable files from within the ~/.scripts/ directory
# dependencies: fzf fd get-clip.sh

# choose script to run
script_dir=~/.scripts
path_to_script=$(
    cd $script_dir || exit
    fd -t x . . | fzf -i --height=80% --layout=reverse \
                  --prompt='Which tool? '\
                  --preview="~/.scripts/dotfiles/fzf-preview.sh {}")

if [ -n "$path_to_script" ] ; then
    path_to_script="$script_dir/$path_to_script"
    ~/.scripts/commands/get-clip.sh "$path_to_script"
    # execute script and print the call
    $path_to_script "$1" "$2"
    printf "\n\n%s %s %s\n" "$path_to_script" "$1" "$2"
else
    echo "run script cancelled."
fi
