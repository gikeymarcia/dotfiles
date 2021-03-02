#!/bin/bash
# Mikey Garcia, @gikeymarcia
# use fzf to pick an emoji and copy it to tmux buffer
# dependencies: fzf tmux
# environment:

emoji_file=~/.config/unicode/emoji.txt
list=$(sed "/^#.*$/d" "$emoji_file" | sed -E "s/^.*\((.*)\) (.*)$/\1\t\2/" \
       | nl )
sel=$(printf "%s" "$list" | fzf --prompt="which emoji? " --height=90%)
if [ -n "$sel" ] ; then
    emoji=$(printf "%s" "$sel" | awk '{print $2}')
    echo "selected emoji '$emoji'"
    [ -n "$TMUX" ] && tmux set-buffer "$emoji"
    # cant use ~/.scripts/commands/get-clip.sh
    # because emoji in clipboard break dmenu (clipmenu uses dmenu)
fi
