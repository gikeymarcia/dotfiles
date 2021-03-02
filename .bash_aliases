#!/bin/bash
# shellcheck disable=SC2139
# Mikey Garcia, @gikeymarcia

# preferred flags for common system commands
alias sc="systemctl --no-pager"
alias scu="systemctl --no-pager --user"
alias ls="ls --color=auto --group-directories-first -F"
alias la="ls --color=auto --group-directories-first -lhAH"
alias ll="ls --color=auto --group-directories-first -lh1FH"
alias lll="ls --color=always --group-directories-first -lAh1FH | less -R"
alias llf="ls --color=always --group-directories-first -lAh1FH | fzf --ansi --header-lines=1"
alias mv="mv -vi"
alias cp="cp -vi"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias chmod="chmod -c"
alias du="du -h"
alias less="less -R"
alias entr="entr -rpc"
alias xclip="xclip -sel clip"
alias df="df -h"

# navigation
alias bm="source ~/.scripts/commands/bookmark-actions.sh"
alias bms='source ~/.scripts/commands/bookmark-actions.sh shell'
alias bme='source ~/.scripts/commands/bookmark-actions.sh editor'
alias j='source ~/.scripts/commands/jump.sh'
alias j..="source move-term.sh jump-back.py"
alias ..="cd .. && ls -lAhH"
alias tp="$HOME/.scripts/commands/tree-preview.sh"
alias grab=~/.scripts/commands/grab.sh
alias srch=~/.scripts/commands/search.sh
alias pull=~/.scripts/commands/pull.sh

# git
alias gs="clear && git status"
alias ga="git add -v --"
alias gd="git diff -P HEAD"
alias gu="git add -u -v"
alias gb="git branch -a"
alias gl="git log --oneline -n 15"
alias gll="git log --oneline"

# program shorcuts
alias clipmenu="env CM_LAUNCHER=fzf clipmenu"
alias ap="ansible-playbook"
alias vim="nvim"
function r (){
    # launch ranger or if already nested, exit back to ranger
    if [ -z "$RANGER_LEVEL" ]; then
        ranger "$@"
    else
        exit
    fi
}
alias r="ranger"
alias b="buku --suggest"
alias p="rand-ping.py"
alias py="py-code.py"
alias mdp=~/.scripts/pandoc/markdown-preview.sh
alias mdw=~/.scripts/pandoc/markdown-watch.sh
alias mdd=~/.scripts/pandoc/markdown-dir.sh
alias rhist='source ~/.scripts/commands/delete-history-entry.sh'
alias ghost='source ~/.scripts/commands/ghost.sh'
alias power=~/.scripts/power-settings/power-profile.sh
alias rsync="rsync --info=progress2"
alias ytdl-audio="youtube-dl -x --prefer-free-formats"
alias ytdl-list='youtube-dl -o "./%(autonumber)s--%(title)s.%(ext)s"'
alias ytdl-info='~/.scripts/commands/ytdl-info.sh'
alias tor='transmission-remote -n "$(cat ~/.config/transmission-remote/cred.txt)"'
# nordvpn
alias ns="nordvpn status"
alias nd="nordvpn disconnect"
alias nc="nordvpn connect"
# anaconda
alias ca="conda activate"
alias cU="conda update conda"
alias jn="jupyter notebook --ip=0.0.0.0 --port=8080"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# tmux selector and creator
alias t=~/.scripts/tmux/tmux-quick-launcher.sh

# manage dotfiles -- https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME'
alias pubcfg='/usr/bin/git --git-dir=$PUB_DOTFILES --work-tree=$HOME'
alias con=~/.scripts/python/dotfiles.py
alias rs=~/.scripts/commands/run-script.sh
alias es='dotfiles.py edit'
alias d.='dotfiles.py'
alias d.e='dotfiles.py edit'
alias d.a='dotfiles.py add'
alias d.s='dotfiles.py search'
alias d.o="source move-term.sh dotfiles.py edit o"
alias d.l='dotfiles.py log'
alias d.d='dotfiles.py diff'

# lifelog
alias life=~/.scripts/digital-life-log/lifelog.sh
alias slog=~/.scripts/digital-life-log/search-log.sh
alias mlog=~/.scripts/digital-life-log/move-log.sh
alias jrn=~/.scripts/digital-life-log/make-journal.sh
alias rq=~/.scripts/commands/random-quote.sh
alias today=~/.scripts/digital-life-log/get-today.sh
alias day=~/.scripts/digital-life-log/make-day.sh
