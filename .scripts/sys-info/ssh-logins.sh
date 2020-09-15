#!/bin/bash
# Mikey Garcia, @gikeymarcia
# ${1} PARAMETER VALUES
# ''  send output to terminal
# v   open result in $EDITOR
# *   refresh output each ${1} second


get_logins () {
    tac <(grep 'Accepted ' <(grep 'sshd' /var/log/auth.log))
}
get_ssh () {
    tac <(grep 'sshd' /var/log/auth.log)
}


if [ "$1" = "v" ]; then
    $EDITOR -R <(get_logins) -c ":set filetype=messages"
else
    get_logins
    while [ -n "$1" ]
    do
        sleep "$1"
        reset
        date
        get_logins
    done
fi
