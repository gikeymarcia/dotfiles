# shellcheck shell=sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# only add to the $PATH once
add_to_path () {
    add=$1
    in_path=$(echo "$PATH" | grep -c "$add")
    #echo "$in_path:$add"
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
# dynamic-colors
add_to_path ~/.dynamic-colors/bin

# environment variables
. ~/.bash_env
