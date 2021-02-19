# shellcheck shell=sh

# ~/.profile: executed for login shells
#   Sourced by my ~/.bash_profile
#   By default ignored in presence of ~/.bash_profile or ~/.bash_login

# default umask set in /etc/profile
# for ssh login umask use `libpam-umask` package
#umask 022

# only add to the $PATH once
add_to_path () {
    add=$1
    in_path=$(echo "$PATH" | grep -c "$add")
    [ ! "$in_path" -gt 0 ] && PATH="$add:$PATH"
}
# local binaries
add_to_path ~/.local/bin
add_to_path ~/.cargo/bin
# my scripts
add_to_path ~/.scripts/commands
add_to_path ~/.scripts/dotfiles
add_to_path ~/.scripts/digital-life-log
add_to_path ~/.scripts/tmux
add_to_path ~/.scripts/pandoc
add_to_path ~/.scripts/sys-info
add_to_path ~/.scripts/remote
add_to_path ~/.scripts/python

# environment variables
. ~/.bash_env
