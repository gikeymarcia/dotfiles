#!/bin/bash
# Mikey Garcia, @gikeymarcia
# ${1} PARAMETER VALUES
# ''  send output to terminal
# v   open result in $EDITOR
# *   refresh output each ${1} second
# environment: $EDITOR

get_ssh () {
    tac <(grep 'sshd' /var/log/auth.log)
}


if [ "$1" = "v" ]; then
    $EDITOR -R <(get_ssh) -c ":set filetype=messages"
else
    get_ssh
    while [ -n "$1" ]
    do
        sleep "$1"
        reset
        date
        get_ssh
    done
fi
