#!/bin/bash
# put shell in no history mode
unset HISTFILE

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # COLOR PROMPT
    # shellcheck source=/home/mikey/.bash_color_codes
    source ~/.bash_color_codes
    chrome="${BICyan}"
    usap="${BPurple}"
    TIME="${BIWhite}\A"
    USERatCOMP="${chrome}[${usap}stranger${chrome}@${usap}\h${chrome}]"
    PROMPT_LOC="${BICyan}\w${BIWhite}\$"
    PROMPT_DIRTRIM=2
    # shellcheck disable=SC2154
    PS1=" $TIME ${debian_chroot:+($debian_chroot)}${USERatCOMP}${PROMPT_LOC} ${Color_Off}"
else
    # NO COLOR PROMPT
    PS1=' \A ${debian_chroot:+($debian_chroot)}stranger@\h:\w\$ '
fi
