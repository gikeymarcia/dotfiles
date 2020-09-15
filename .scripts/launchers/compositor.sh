#!/bin/sh
# Mikey Garcia, @gikeymarcia
# Turns window transparency effects on/off
# Switches between available configuration files
# using 'picom' as the Xorg compositor
# dependencies: dmenu picom

# https://wiki.archlinux.org/index.php/Picom

# options: default (select compositor profile)
#          on  -- turn on picom with default profile
#          off -- kill picom

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env
picom_dir=~/.config/picom

option="$1"
case "$option" in
    "off" )
        ~/.scripts/commands/nice_shutdown.sh picom &
        ;;
    "on" )
        ~/.scripts/commands/nice_shutdown.sh picom
        picom --config "$picom_dir/normal-classy.conf" &
        ;;
    * )
        ~/.scripts/commands/nice_shutdown.sh picom &
        # shellcheck disable=SC2086
        choice=$(
            cd $picom_dir || exit
            fd -e conf . .  |
            dmenu -i -l 20 $DMENU_COLORS \
                -fn "$DMENU_FONT" \
                -p 'Which picom config? ')
        [ -n "$choice" ] && picom --config "$picom_dir/$choice"
esac
