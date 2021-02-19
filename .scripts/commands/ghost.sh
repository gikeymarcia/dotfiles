#!/bin/bash
# Mikey Garcia, @gikeymarcia
# put shell in no history mode
# dependencies: bash ~/.bash_color_codes

unset HISTFILE

# COLOR PROMPT
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # shellcheck source=/home/mikey/.bash_color_codes
    source ~/.bash_color_codes
    # PROMPT_DIRTRIM=2
    # 11:23@~/.../last_dir_pieces$
    PS1="${UGreen}\A >~>> ${BYellow}\w${Color_Off}${BIWhite}${Color_Off} $(hostname)\n"
else
    # NO COLOR PROMPT
    PS1='\A@\w\$ '
fi
