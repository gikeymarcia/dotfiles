#!/bin/bash
# Mikey Garcia, @gikeymarcia
# began as Ubuntu 18.04 default ~/.bashrc

# https://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#sect_01_02
# Other relevant locations
# /etc/profile          system-wide profile
# /etc/bash.bashrc      system-wide bashrc
# ~/.profile            login shell
# ~/.bash_profile       to setup bash upon login (I think)
# ~/.bashrc             non-login shell (you are here)
# ~/.inputrc            readline options
# My own tweaks
# ~/.bash_personal      useful system paths and login greeting
# ~/.bash_env           environment variables I want

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

### SHELLCHECK DIRECTIVES
# shellcheck source=/home/mikey/.bash_color_codes

### TERMINAL WORKING ENVIRONMENT
source-existing () {
    [ -r "$1" ] && source "$1"
}

# hacks for running on GoogleComputePlatform
source-existing ~/.bash_gcp

### PIMP MY BASH PROMPT
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # COLOR PROMPT
    source-existing ~/.bash_color_codes           # BASH color escape sequences
    chrome="${BICyan}"
    usap="${BBlue}"
    # TIME="${BIWhite}\A"
    USERatCOMP="${chrome}[${usap}\u${chrome}@${usap}\h${chrome}]"
    PROMPT_LOC="${BICyan}\w${BIWhite}\$"
    PROMPT_DIRTRIM=1
    # shellcheck disable=SC2154
    # TODO figure out the shell expansion going on below
    PS1=" ${debian_chroot:+($debian_chroot)}${USERatCOMP}${PROMPT_LOC} ${Color_Off}"
else
    # NO COLOR PROMPT
    PS1=' \A ${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi


### BASH OPTIONS
## https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
set -o vi               # enable VI-mode
shopt -s cdspell        # spellcheck/autocorrect
shopt -s autocd         # automatically cd into directories
shopt -s dotglob        # match hidden files with glob matching
shopt -s dirspell       # spellcheck/autocorrect
shopt -s globstar       # allow globstar recurisive matching $(ls dir/**)
shopt -s checkwinsize   # update window LINES and COLUMNS after each command
# history options
shopt -s cmdhist        # multi-line commands record to one line
shopt -s histappend     # append to instead of overwrite history file
HISTSIZE=15000
HISTFILESIZE=1000000
HISTIGNORE='ls:ll:clear:..'
HISTCONTROL=ignoreboth:erasedups
# shared terminal history-- https://unix.stackexchange.com/a/18443
#PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# enable programmable completion features
if ! shopt -oq posix; then source-existing /usr/share/bash-completion/bash_completion ; fi

# enable ls color support
eval "$(dircolors -b)"

# set window title
case "$TERM" in
    xterm*|rxvt*|st*|alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac


# shell integrations
source-existing ~/.fzf.bash
source-existing ~/.anaconda3/etc/profile.d/conda.sh
source-existing ~/.dynamic-colors/completions/dynamic-colors.bash

# paths / defaults / aliases
source-existing ~/.bash_personal
source-existing ~/.bash_aliases
source-existing ~/.bash_funcs
source-existing ~/.bash_gcp

# https://www.computerhope.com/unix/bash/bind.htm
bind -f ~/.config/bind/my-bindings

# begin with quick selector by default
if [ -z "$TMUX" ]; then
    figlet -f smslant "enter the tmux"
    ~/.scripts/tmux/tmux-quick-launcher.sh
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mikey/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mikey/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mikey/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mikey/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
