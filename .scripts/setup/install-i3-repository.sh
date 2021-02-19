#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install i3 repo for newest version in Ubuntu (default repo is old)
# dependencies:
# documentation -- https://i3wm.org/docs/repositories.html

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# install key to verify downloads
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48
sudo dpkg -i ./keyring.deb && rm -v ./keyring.deb

# install i3 repo
release="$(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=)"
echo "deb [arch=amd64] https://debian.sur5r.net/i3/ $release universe" |
    sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

# install i3
sudo apt update -y
sudo apt install i3 -y
