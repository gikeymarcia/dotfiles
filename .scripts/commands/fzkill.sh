#!/bin/bash
# Mikey Garcia, @gikeymarcia
# enter a search term and interactivly kill the process using fzf
# dependencies: fzf
# environment:

task=$1
pids=$(pgrep "$task")
if [ -n "$pids" ]; then
    sel=$(printf "%s" "$pids" | xargs ps | fzf --header-lines=1 \
        --prompt="Which process dies? " +m)
    echo "$sel"
    if [ -n "$sel" ]; then
        kpid=$(printf "%s" "$sel" | awk '{print $1}')
        kill "$kpid"
        sleep 1
        if ps "$kpid"; then
            kill -KILL "$kpid"
            ps "$kpid"
        fi
    fi
else
    echo "no instances of '$task' running"
fi
