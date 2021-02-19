#!/bin/bash
# Mikey Garcia, @gikeymarcia
# Install my configs on a fresh system install (after importng dotfiles)
# dependencies: $DOTFILES

# programs
# ~/.scripts/setup/get-all-programs.sh
~/.scripts/python/install-all-programs.py
sudo ln /usr/bin/batcat /usr/bin/bat
sudo ln /usr/bin/fdfind /usr/bin/fd
~/.scripts/setup/install-i3-repository.sh
~/.scripts/setup/build-picom.sh
~/.scripts/setup/build-qtile.sh
~/.scripts/setup/install-clipmenu-ubuntu-20.04.sh
~/.scripts/system/vim-fresh.sh
~/.scripts/setup/install-coc-extensions.sh

# dotfiles
~/.scripts/setup/link-root-dot.sh

# build pulseaudio-ctl
~/.scripts/setup/pull-git-repos.sh
cd ~/Documents/git_repos/programs/pulseaudio-ctl || exit 1
sudo make install
