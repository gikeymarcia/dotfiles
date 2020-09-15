#!/bin/bash
# Mikey Garcia, @gikeymarcia
# script to build and install qtile window manager from pip3
# dependencies: git
# http://docs.qtile.org/en/latest/manual/install/index.html#installing-from-source

apt_dependencies="libxcb-render0-dev libffi-dev libpangocairo-1.0-0 python-dbus"
# shellcheck disable=SC2086
sudo apt install $apt_dependencies
pip3 install cairocffi xcffib

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

qtile_repo=~/Documents/git_repos/qtile
if [ ! -d $qtile_repo/.git ]; then
    mkdir -pv "$qtile_repo"
    git clone git://github.com/qtile/qtile.git "$qtile_repo"
fi

cd $qtile_repo
git pull
pip3 install qtile


# write xsession file
tmpx=/tmp/qtile.desktop
cat > $tmpx <<EOF
[Desktop Entry]
Name=Qtile
Comment=Qtile pythonic dynamic window manager
Exec=$(which qtile)
Type=Application
Keywords=wm;tiling
EOF
# move it to the right place
xsession=/usr/share/xsessions/qtile.desktop
sudo mv -v $tmpx $xsession
ls -l /usr/share/xsessions
bat $xsession
