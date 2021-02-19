#!/bin/bash
# Mikey Garcia, @gikeymarcia
# install clipmenu from github for Ubuntu 20.04
# dependencies: git

# install dependencies
sudo apt install libxfixes3 xsel xdotool

# clone repos
repos=~/temp-ubuntu-clipmenu
menu=$repos/clipmenu
notify=$repos/clipnotify
[ ! -d "$repos" ] && mkdir -pv $repos
git clone https://github.com/cdown/clipnotify.git "$notify"
git clone https://github.com/cdown/clipmenu.git --branch master "$menu"

# build and install clipnotify
cd "$notify" || exit 1
make --file Makefile || echo "failed to build clipnotify."
sudo cp -fv "$notify/clipnotify" /usr/bin/ && sudo chmod 755 /usr/bin/clipnotify

# install clipmenu
cd "$menu" || exit
sudo cp -fv "$menu/clipmenu" /usr/bin/ && sudo chmod 755 /usr/bin/clipmenu
sudo cp -fv "$menu/clipmenud" /usr/bin/ && sudo chmod 755 /usr/bin/clipmenud
sudo cp -fv "$menu/clipdel" /usr/bin/ && sudo chmod 755 /usr/bin/clipdel
sudo cp -fv "$menu/clipctl" /usr/bin/ && sudo chmod 755 /usr/bin/clipctl

sudo rm -r $repos

# install systemd unit file
unit_file="$HOME/.system-files/systemd-unit-files/clipmenud.service"
unit_file="$menu/init/clipmenud.service"
unit_name=$(basename "$unit_file")
sysd=/usr/lib/systemd/user
if [ -r "$unit_file" ]; then
    systemctl --user stop "$unit_name"
    sudo cp -v "$unit_file" "$sysd/$unit_name"
    systemctl --user daemon-reload
    systemctl --user enable "$unit_name"
    systemctl --user start "$unit_name"
    # view results
    systemctl --no-pager --user status -l "$unit_name"
    systemctl --no-pager --user cat "$unit_name"
else
    echo "no unit file @:"
    echo "$unit_file"
fi
