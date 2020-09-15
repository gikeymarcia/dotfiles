#!/bin/sh
# Mikey Garcia, @gikeymarcia
# fzf selector to attach-to/create tmux sessions
# dependencies: fzf
# https://www.arp242.net/tmux.html

sessions="$(tmux ls 2> /dev/null)"
[ -z "$sessions" ] && echo "no sessions."
# choose your tmux session
selector=$(printf "%s" "$sessions" | sed 's :.*attached.* @ ;s :.*$  ' |
    fzf --no-multi -i --reverse --print-query \
    --border --height=20 --inline-info --margin 5%,5%,5%,0% \
    --prompt="Which tmux session? " \
    --preview="echo {} | sed 's/@$//' | xargs tmux list-windows -t"|
    sed 's|@$||')

# logic to determine script behavior
[ -z "$selector" ] && echo "selection cancelled." && exit
if [ "$(echo "$selector" | wc -l)" = 2 ]; then
    # attach to existing session
    target=$( echo "$selector" | sed -n 2p )
    printf "$  %s\n" "tmux attach -t $target"

    if [ -z "$TMUX" ]; then
        env TERM=screen-256color tmux attach -t "$target"
    else
        env TERM=screen-256color tmux switch-client -t "$target"
    fi
else
    # create new session
    target=$( echo "$selector" | sed "s|*$||" )
    [ -z "$target" ] && echo "selection cancelled!" && exit
    printf "$  %s\n" "tmux new-session -s ${target}"
    if [ -z "$TMUX" ]; then
        env TERM=screen-256color tmux new-session -s "${target}"
    else
        env TERM=screen-256color tmux new-session -d -s "${target}"
        env TERM=screen-256color tmux switch-client -t "${target}"
    fi
fi
