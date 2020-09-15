#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install brave-browser for Ubuntu 20.04
# dependencies:

brave_key=https://brave-browser-apt-release.s3.brave.com/brave-core.asc
local_key_loc=/etc/apt/trusted.gpg.d/brave-browser-release.gpg
# get brave key and add to repos
curl -s $brave_key | sudo apt-key --keyring $local_key_loc add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" |
    sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# install
sudo apt update
sudo apt install brave-browser
