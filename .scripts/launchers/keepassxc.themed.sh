#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch keepassxc

passDB="$HOME/.config/keepassxc/MikeyPasswords.kdbx"
keepassxc "$passDB" &
