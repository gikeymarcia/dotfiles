#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install i3 repo for newest version in Ubuntu (default repo is old)
# dependencies:
# documentation -- https://i3wm.org/docs/repositories.html

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# get key to verify unaltered repo downloads
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48
dpkg -i ./keyring.deb
rm -v ./keyring.deb
echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list

# install i3
apt update
apt install i3
