#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install my dotfiles from gitlab
# dependencies:
# https://www.atlassian.com/git/tutorials/dotfiles

export LOCAL_REPO=~/.config/dotfiles
export REMOTE_DOTFILES="git@gitlab.com:gikeymarcia/dotfiles.git"

# make dir to hold repo
if [ ! -d $LOCAL_REPO ]; then
    mkdir -pv $LOCAL_REPO
    git clone --bare "$REMOTE_DOTFILES" $LOCAL_REPO
fi

# make command shortcut to interact with dotfiles repo
config="/usr/bin/git --git-dir=$LOCAL_REPO --work-tree=$HOME"

$config config --local status.showUntrackedFiles no

# backup any files which would be overwritten
cd ~ || exit 1
mkdir -p ~/.config-backup && \
$config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' |
    xargs -I{} mv -v {} "$HOME/.config-backup/"{}

# dotfile repo status
$config branch -a
$config status
