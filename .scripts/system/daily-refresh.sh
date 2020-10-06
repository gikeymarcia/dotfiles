#!/bin/sh
# Mikey Garcia, @gikeymarcia
# run updates, clean logs, runs in cronjob

sudo journalctl --vacuum-size=1G
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo youtube-dl -U
