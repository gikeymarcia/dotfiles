#!/bin/bash
# Mikey Garcia, @gikeymarcia
# began as Ubuntu 18.04 default ~/.bashrc

# https://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#sect_01_02
# Other shell config locations
# /etc/profile          system-wide profile
# /etc/bash.bashrc      system-wide bashrc
# ~/.profile            login shell
# ~/.bash_profile       runs on each new shell
# ~/.bashrc             interactive shell config
# ~/.inputrc            readline options
# My own tweaks
# ~/.bash_personal      useful system paths and login greeting
# ~/.bash_env           environment variables I want
# ~/.bash_func          helper functions

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
# https://unix.stackexchange.com/a/3174
[ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)

source-existing ~/.bash_gcp  # hack for GoogleComputePlatform

### PIMP MY BASH PROMPT (man bash /PROMPTING)
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then # COLOR PROMPT
    # https://unix.stackexchange.com/a/124409
    source-existing ~/.bash_color_codes
    user="${debian_chroot:+}${BBlue}\u${BICyan}@${BBlue}\H"
    workdir="${White}:${Blue}\w${Color_Off}"
    time="${White}\A"
    PS1="$user$workdir $time$Color_Off\n"
else # NO COLOR PROMPT
    PS1="\A ${debian_chroot:+}\u@\h:\w\$ "
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

# enable programmable completion features
if ! shopt -oq posix; then
    source-existing /usr/share/bash-completion/bash_completion
    source-existing ~/.config/completion/watson.completion
    source-existing ~/.config/completion/buku-completion.bash
    [ -x pandoc ] && eval "$(pandoc --bash-completion)"
    # Anaconda bash completion
    # CONDA_ROOT=~/anaconda3
    # source-existing $CONDA_ROOT/etc/profile.d/bash_completion.sh
fi

# enable ls color support
eval "$(dircolors -b ~/.config/dircolors/my.dircolors)"

# set window title
case "$TERM" in
    xterm*|rxvt*|st*|alacritty)
    PS1="\[\e]0;${debian_chroot:+}\u@\h: \w\a\]$PS1"
    ;;
esac


# shell integrations
source-existing ~/.fzf.bash
# source-existing ~/.anaconda3/etc/profile.d/conda.sh

# paths / defaults / aliases
source-existing ~/.bash_env
source-existing ~/.bash_personal
source-existing ~/.bash_aliases
source-existing ~/.bash_funcs
source-existing ~/.bash_gcp

# https://www.computerhope.com/unix/bash/bind.htm
#bind -f ~/.config/bind/my-bindings
bind '"\C-l": clear-screen'

# begin with tmux quick selector by default
if [ -z "$TMUX" ]; then
    ~/.scripts/tmux/tmux-quick-launcher.sh
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
