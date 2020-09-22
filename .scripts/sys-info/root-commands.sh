#!/bin/bash
# Mikey Garcia, @gikeymarcia
# check logs for root commands on the system
# environment: $EDITOR

$EDITOR -R <(tac <(grep 'sudo' /var/log/auth.log | grep 'USER')) \
    -c ":set filetype=messages"
