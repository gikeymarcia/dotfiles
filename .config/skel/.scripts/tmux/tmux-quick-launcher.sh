#!/bin/sh
# Mikey Garcia, @gikeymarcia
# fzf selector to attach-to/create tmux sessions
# dependencies: fzf tmux
# environment: $CUST_TMUX_TERM
# https://www.arp242.net/tmux.html

sessions="$(tmux ls -F '#S#{?session_attached,@,}' 2> /dev/null)"
[ -z "$sessions" ] && echo "no sessions."

# custom preview formatting
regex_home=$(echo "$HOME" | sed "s / . g")
Frmt="#I#{?window_active,*,#{?window_last_flag,-, }} (#{window_panes})#W  #{s/^$regex_home/~/r:pane_current_path}"
fzf_preview="echo {} | sed 's/@$//' | xargs --no-run-if-empty tmux list-windows -F '$Frmt' -t"
# custom $TERM to support tmux + vim + italics
if [ -n "$CUST_TMUX_TERM" ]; then
    ENV_TERM="env TERM=$CUST_TMUX_TERM"
else
    ENV_TERM=""
fi

# choose your tmux session
selector=$(echo "$sessions" |
    fzf --no-multi -i --reverse --print-query \
    --border --height=20 --inline-info --margin 5%,5%,5%,0% \
    --prompt="Which tmux session? " \
    --preview="$fzf_preview" |
    sed 's|@$||')

# logic to determine script behavior
[ -z "$selector" ] && echo "selection cancelled." && exit
if [ "$(echo "$selector" | wc -l)" = 2 ]; then
    # attach to existing session
    target=$( echo "$selector" | sed -n 2p )
    printf "$  %s\n" "tmux attach -t $target"

    if [ -z "$TMUX" ]; then
        $ENV_TERM tmux attach -t "$target"
    else
        $ENV_TERM tmux switch-client -t "$target"
    fi
else
    # create new session
    target=$( echo "$selector" | sed "s|*$||" )
    [ -z "$target" ] && echo "selection cancelled!" && exit
    printf "$  %s\n" "tmux new-session -s ${target}"
    if [ -z "$TMUX" ]; then
        $ENV_TERM tmux new-session -s "${target}"
    else
        $ENV_TERM tmux new-session -d -s "${target}"
        $ENV_TERM tmux switch-client -t "${target}"
    fi
fi
