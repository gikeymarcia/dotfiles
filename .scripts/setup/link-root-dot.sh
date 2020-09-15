#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install niceities for the system root user
# dependencies:

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

backup_root=/root/.old_root_dotfiles
[ ! -d "$backup_root" ] && sudo mkdir -pv "$backup_root"

# bash
binds=~/.config/bind/my-bindings
sudo cp -v "$binds"                         /root/.binds
sudo cp -v "$HOME/.root/root_aliases"       /root/.bash_aliases
sudo cp -v "$HOME/.root/root_bash_profile"  /root/.bash_profile
sudo cp -v "$HOME/.root/root_color_codes"   /root/.bash_color_codes
sudo cp -v "$HOME/.root/root_rc"            /root/.bashrc
sudo cp -v "$HOME/.root/root_env"           /root/.bash_env
sudo cp -v "$HOME/.inputrc"                 /root/.inputrc
sudo cp -v "$HOME/.root/root_profile"       /root/.profile
sudo cp -v "$HOME/.selected_editor"         /root/.selected_editor

# custom TERM for tmux / vim
termdir=".terminfo/s"
sudo [ ! -d "/root/$termdir" ] && sudo mkdir -pv "/root/$termdir"
sudo cp -v "$HOME/$termdir/screen-256color-italic"  "/root/$termdir"

# nvim
nv_cfg=/root/.config/nvim
vm_cfg=/root/.vim/undo
[ ! -d "$nv_cfg" ]  && sudo mkdir -pv "$nv_cfg"
[ ! -d "$vm_cfg" ]  && sudo mkdir -pv "$vm_cfg"
sudo cp -v "$HOME/.config/nvim/init.vim"    "$nv_cfg"
sudo cp -v "$HOME/.root/root_vimrc"         /root/.vimrc

# fzf
sudo cp -v "$HOME/.fzf.bash" /root/.fzf.bash
fzf_comp=/root/Documents/git_repos/fzf/shell
[ ! -d "$fzf_comp" ] && sudo mkdir -pv "$fzf_comp"
sudo cp -v "$HOME/Documents/git_repos/fzf/shell/completion.bash"   "$fzf_comp"
sudo cp -v "$HOME/Documents/git_repos/fzf/shell/key-bindings.bash" "$fzf_comp"
