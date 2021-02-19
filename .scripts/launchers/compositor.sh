#!/bin/sh
# Mikey Garcia, @gikeymarcia
# Turns window transparency effects on/off
# Switches between available configuration files
# using 'picom' as the Xorg compositor
# dependencies: dmenu picom nice_shutdown.sh

# https://wiki.archlinux.org/index.php/Picom

# options: default (select compositor profile)
#          on  -- turn on picom with default profile
#          off -- kill picom

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

err_log=/tmp/compositor
# picom keeps crashing in 20.10
compositor="/usr/bin/picom"
compositor="/usr/bin/picom --show-all-xerrors --experimental-backends"
config_dir=~/.config/picom

option="$1"
case "$option" in
    "off" )
        nice_shutdown.sh picom &
        ;;
    "on" )
        nice_shutdown.sh picom
        $compositor --config "$config_dir/opaque.conf" 2>> "$err_log"
        ;;
    * )
        nice_shutdown.sh picom &
        # shellcheck disable=SC2086
        choice=$(
            cd $config_dir || exit
            fd -e conf . .  |
            dmenu -i -l 20 $DMENU_COLORS -fn "$DMENU_FONT" \
                -p 'Which compositor config? ')
        if [ -n "$choice" ]; then
            msg="$(date)::running::$compositor --config '$config_dir/$choice'"
            echo "$msg" >> "$err_log"
            $compositor --config "$config_dir/$choice" 2>> "$err_log"
        fi
esac
