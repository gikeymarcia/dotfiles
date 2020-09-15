#!/bin/bash
# INCOMPLETE!
## https://wiki.archlinux.org/index.php/Bluetooth_headset#Headset_via_Bluez5/PulseAudio

## device | MAC-address
## NP11   | 20:19:09:85:1C:E5
## Z8     | 11:11:22:03:33:78

## Bluetooth actions
bt_off () {
    printf "%s\n" "power off" | bluetoothctl
}

connect_np11 () {
    printf "%s\n%s\n%s\n" "power on" "agent on" "connect 20:19:09:85:1C:E5" | bluetoothctl

}

connect_z8 () {
    printf "%s\n%s\n" "power on" "connect 20:19:09:85:1C:E5" | bluetoothctl
}


case "$1" in
    "Z8" )
        connect_z8
        echo "Z8" ;;
    "NP11" )
        connect_np11
        echo "NP11" ;;
    "off" )
        bt_off
        echo "bluetooth power off" ;;
    * ) echo "otherwise"
esac

printf "%s\n%s\n%s\n" "OFF" "NootPhones" "Z8 - bone conductive" |
    dmenu -i -l 25 $DMENU_COLORS \
    -fn "$DMENU_FONT" \
    -p "BT actions: "


## example commands
# printf "%s\n%s\n" "power on" "list" | bluetoothctl
# printf "%s\n" "power off" | bluetoothctl

