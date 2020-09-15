#!/bin/bash
# Mikey Garcia, @gikeymarcia

# user must be in 'video' group
# udev rule must be installed and loaded
# /etc/udev/rules.d/keyboard.rules
#   ACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", RUN+="/bin/chgrp video /sys/class/leds/smc::kbd_backlight/brightness"
#   ACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", RUN+="/bin/chmod g+w /sys/class/leds/smc::kbd_backlight/brightness"

# size of change for each up/down command
step=8

# important locations
#/sys/class/leds/smc::kbd_backlight/
brightness_dir=/sys/class/leds/smc::kbd_backlight/
brightness=$(cat "$brightness_dir/brightness" )
max_brightness=$(cat "$brightness_dir/max_brightness" )

# functions that modify system values
up () {
    new=$((brightness + step))
    if ((new > max_brightness)); then new="$max_brightness"; fi
    echo "$new" > "$brightness_dir/brightness"
}
down () {
    new=$((brightness - step))
    if ((new < 1 )); then new=0; fi
    echo "$new" > "$brightness_dir/brightness"
}
setter () {
    new=$1
    echo "$new" > "$brightness_dir/brightness"
    notify-send -u normal -t 8000 \
        "<b>Keyboard LED set</b>" \
        "<b>$new/$max_brightness</b>" \
        -a sys
}

## logic to determine which action to take
case "$1" in
    "up" ) up
    ;;
    "down" ) down
    ;;
    "set" ) setter "$2"
    ;;
    "status" )
        notify-send -u normal -t 8500 \
        "STATUS" "brightness: $brightness
                  max brightness: $max_brightness"
    ;;
    * ) echo "I don't do '$1'."
        echo "My options are:"
        echo "up, down, set 'INTERGER_VALUE'"
    ;;
esac
