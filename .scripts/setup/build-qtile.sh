#!/bin/bash
# Mikey Garcia, @gikeymarcia
# script to build and install qtile window manager from pip3
# dependencies: pip3
# http://docs.qtile.org/en/latest/manual/install/index.html#installing-from-source

apt_dependencies="libxcb-render0-dev libffi-dev libpangocairo-1.0-0 python-dbus"
# shellcheck disable=SC2086
sudo apt install $apt_dependencies
# https://github.com/qtile/qtile/issues/994#issuecomment-497984551
pip3 install xcffib
pip3 install --no-cache-dir cairocffi
pip3 install --no-cache-dir qtile

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# write xsession file
tmpx=/tmp/qtile.desktop
cat > $tmpx <<EOF
[Desktop Entry]
Name=Qtile
Comment=Qtile the pythonic dynamic window manager
Exec=$(which qtile)
Type=Application
Keywords=wm;tiling
EOF
# move it to the right place
xsession=/usr/share/xsessions/qtile.desktop
sudo mv -v $tmpx $xsession
ls -l /usr/share/xsessions
bat $xsession
