#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install signal-desktop for linux
# dependencies:


# get key and add signal repository
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# install
sudo apt update
sudo apt install signal-desktop
