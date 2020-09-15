#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch keepassxc using the gtk theme

passDB=~/.config/keepassxc/MikeyPasswords.kdbx
env QT_QPA_PLATFORMTHEME=gtk2 keepassxc $passDB &
