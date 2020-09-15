#!/bin/sh
# Mikey Garcia, @gikeymarcia
# all packages needed to run polybar on Ubuntu 20.04
# dependencies:
# https://github.com/polybar/polybar/wiki/Compiling
# shellcheck disable=SC2086

# hard build and run dependencies
hard_dependencies="build-essential git cmake cmake-data pkg-config \
python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev \
libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev \
libxcb-ewmh-dev libxcb-icccm4-dev"
sudo apt install $hard_dependencies -y

# optional run dependencies
optional_dependencies="libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev \
libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
libnl-genl-3-dev"
sudo apt install $optional_dependencies

# date modified: 2019 Aug 28
