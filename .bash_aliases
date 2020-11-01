#!/bin/bash
# Mikey Garcia, @gikeymarcia

# preferred flags for common system commands
alias ls="ls --color=auto --group-directories-first -F"
alias la="ls --color=auto --group-directories-first -lhAH"
alias ll="ls --color=auto --group-directories-first -lh1FH"
alias mv="mv -v"
alias cp="cp -v"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias chmod="chmod -v"
alias du="du -h"
alias less="less -R"
alias entr="entr -rpc"
alias xclip="xclip -sel clip"

# navigation
alias bm="source ~/.scripts/commands/bookmark-actions.sh"
alias bms='source ~/.scripts/commands/bookmark-actions.sh shell'
alias bme='source ~/.scripts/commands/bookmark-actions.sh editor'
alias j='source ~/.scripts/commands/jump.sh'
alias ..="cd .. && ls -lAhH"
alias tp=~/.scripts/commands/tree-preview.sh
alias grab=~/.scripts/commands/grab.sh
alias srch=~/.scripts/commands/search.sh
alias pull=~/.scripts/commands/pull.sh

# git
alias gs="git status"
alias ga="git add -v"

# program shorcuts
alias clipmenu="env CM_LAUNCHER=fzf clipmenu"
alias vim="nvim"
alias r="ranger"
alias mdp=~/.scripts/pandoc/markdown-preview.sh
alias mdw=~/.scripts/pandoc/markdown-watch.sh
alias rhist='source ~/.scripts/commands/delete-history-entry.sh'
alias ghost='source ~/.scripts/commands/ghost.sh'
alias power=~/.scripts/power-settings/power-profile.sh
alias ytdl-audio="youtube-dl --config-location ~/.config/youtube-dl/audio"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# tmux selector and creator
alias t=~/.scripts/tmux/tmux-quick-launcher.sh

# manage dotfiles -- https://www.atlassian.com/git/tutorials/dotfiles
# shellcheck disable=SC2139
alias config='/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME'
alias pubcfg='/usr/bin/git --git-dir=$PUB_DOTFILES --work-tree=$HOME'
alias con=~/.scripts/dotfiles/config.sh
alias rs=~/.scripts/commands/run-script.sh
alias es=~/.scripts/dotfiles/edit-config-file.sh

# lifelog
alias life=~/.scripts/digital-life-log/lifelog.sh
alias slog=~/.scripts/digital-life-log/search-log.sh
alias mlog=~/.scripts/digital-life-log/move-log.sh
alias jrn=~/.scripts/digital-life-log/make-journal.sh
alias rq=~/.scripts/commands/random-quote.sh
alias today=~/.scripts/digital-life-log/get-today.sh
alias day=~/.scripts/digital-life-log/make-day.sh
