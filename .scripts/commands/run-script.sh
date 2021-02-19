#!/bin/bash
# Mikey Garcia, @gikeymarcia
# Run executable files from within the ~/.scripts/ directory
# dependencies: fzf fd get-clip.sh

# silly prompt
if [ -x "$(which figlet)" ] && [ -x "$(which lolcat)" ]; then
    font="$HOME/.config/figlet/5lineoblique.flf"
    [ ! -r "$font" ] && font=smslant
    figlet -f "$font" -c "run!" | lolcat
fi
# choose script to run
script_dir=~/.scripts
path_to_script=$(
    cd $script_dir || exit
    fd -t x . . | fzf -i --height=80% --layout=reverse \
                  --prompt='Which tool? '\
                  --preview="~/.scripts/dotfiles/fzf-preview.py {}")

if [ -n "$path_to_script" ] ; then
    path_to_script="$script_dir/$path_to_script"
    ~/.scripts/commands/get-clip.sh "$path_to_script"
    # execute script and print the call
    $path_to_script "$1" "$2"
else
    echo "run script cancelled."
fi
