#!/bin/sh
# Mikey Garcia, @gikeymarcia
# pull dotfiles repo from web to catch up to the most recent commit
# dependencies: git $DOTFILES

# define variable for controlling dotfiles
export config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME"

# capture active branch
current_branch="$($config status | grep "On branch" | awk '{ print $3 }')"

# update desktop and laptop config branches
cd "$HOME" || exit 1
$config fetch --all
$config checkout laptop  && $config pull
$config checkout desktop && $config pull
$config checkout "$current_branch"
