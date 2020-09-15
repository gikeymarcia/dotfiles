#!/bin/bash
# Mikey Garcia, @gikeymarcia
# ~/.bash_logout: executed by bash when login shell exits

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
    # shellcheck disable=SC2020
    figlet -f slant "$(echo 'adios!-mikey was here' | tr '-' '\n\n' )" |
        lolcat -F .05
fi
