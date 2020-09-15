#!/bin/sh
# Mikey Garcia, @gikeymarcia
# make F1-12 keys work without fn mode
# fn mod for media keys

echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
