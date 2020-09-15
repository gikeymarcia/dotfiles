#!/bin/sh
# Mikey Garcia, @gikeymarcia
# build and install picom from git repo
# dependencies: git
# script=~/.scripts/setup/build-picom.sh; echo $script | entr -rpc $script

# install system dependencies
deb_dependencies="libxext-dev libxcb1-dev libxcb-damage0-dev \
libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev \
libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev \
libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev \
libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev \
uthash-dev libev-dev libx11-xcb-dev asciidoc ninja-build"
# shellcheck disable=SC2086
sudo apt install $deb_dependencies
sudo pip3 install meson


# get repo contents
picomgit=~/Documents/git_repos/picom
[ ! -d $picomgit ] && mkdir -pv $picomgit
cd $picomgit || exit 1
if [ -d ./.git ]; then
    git status
    git stash
    git checkout master
    git pull
else
    git clone https://github.com/yshui/picom.git -b master $picomgit
fi


# install instructions from picom github
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

#sudo rm -r "$picomgit"


# references:
# https://wiki.archlinux.org/index.php/Picom
# https://github.com/yshui/picom/tree/master -- search Debian
# https://mesonbuild.com/Quick-guide.html
