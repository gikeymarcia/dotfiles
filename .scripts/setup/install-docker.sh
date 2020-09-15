#!/bin/sh
# Mikey Garcia, @gikeymarcia
# slightly adapted from the docker documentation @
# https://docs.docker.com/engine/install/ubuntu/#installation-methods
#      _            _
#   __| | ___   ___| | _____ _ __
#  / _` |/ _ \ / __| |/ / _ \ '__|
# | (_| | (_) | (__|   <  __/ |
#  \__,_|\___/ \___|_|\_\___|_|


if [ "$1" = "purge" ]; then
    echo "warning: you are about to complete purge docker from your system."
    echo "if you want to proceed provide the root password"
    sudo apt-get purge docker-ce docker-ce-cli containerd.io
    sudo rm -rf /var/lib/docker
    sudo apt-key del 0EBFCD88
    release=$(lsb_release -cs)
    sudo add-apt-repository -r \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu $release stable"
    sudo apt update -y
    exit
fi

# get ready to install docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates \
    curl gnupg-agent software-properties-common

# install and verify docker gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# install docker engine
release=$(lsb_release -cs)
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $release stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
