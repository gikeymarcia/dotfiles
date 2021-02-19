#!/bin/bash
# base aliases to start
# Mikey Garcia, @gikeymarcia

# preferred flags for common system commands
alias sc="systemctl --no-pager"
alias ls="ls --color=auto --group-directories-first -F"
alias la="ls --color=auto --group-directories-first -lhAH"
alias ll="ls --color=auto --group-directories-first -lh1FH"
alias mv="mv -vi"
alias cp="cp -vi"
alias rm="rm -vi"
alias mkdir="mkdir -pv"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias chmod="chmod -c"
alias du="du -h"
alias less="less -R"
alias xclip="xclip -sel clip"
alias df="df -h"

# navigation
alias ..="cd .. && ls -lAhH"

# git
alias gs="clear && git status"
alias ga="git add -v --"
alias gd="git diff -P HEAD"
alias gu="git add -u -v"
alias gb="git branch -a"

# tmux selector and creator
alias t=~/.scripts/tmux/tmux-quick-launcher.sh

# manage dotfiles -- https://www.atlassian.com/git/tutorials/dotfiles
# shellcheck disable=SC2139
alias config='/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME'
alias pubcfg='/usr/bin/git --git-dir=$PUB_DOTFILES --work-tree=$HOME'
