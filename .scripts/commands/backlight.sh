#!/bin/bash
# Mikey Garcia, @gikeymarcia

# user must be in 'video' group
# udev rule must be installed and loaded
# /etc/udev/rules.d/backlight.rules
#   ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chgrp video /sys/class/backlight/intel_backlight/brightness"
#   ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness"

# https://unix.stackexchange.com/questions/39370/how-to-reload-udev-rules-without-reboot
# sudo udevadm control --reload-rules && udevadm trigger

action=$1
step=275
fine_step=150

# important locations
brightness_dir=/sys/class/backlight/intel_backlight
brightness=$(cat "$brightness_dir/brightness" )
max_brightness=$(cat "$brightness_dir/max_brightness" )

# functions that modify system values
up () {
    if ((brightness < 1600)); then step=$fine_step; fi
    new=$((brightness + step))
    if ((new > max_brightness)); then new="$max_brightness"; fi
    echo "$new" > "$brightness_dir/brightness"
    notify "$new"

}
down () {
    if ((brightness < 1600)); then step=$fine_step; fi
    new=$((brightness - step))
    if ((new < 1 )); then new=0; fi
    echo "$new" > "$brightness_dir/brightness"
    notify "$new"
}
setter () {
    new=$1
    echo "$new" > "$brightness_dir/brightness"
    notify-send -u normal -t 8000 \
        "Backlight set" \
        "<b>$new/$max_brightness</b>" \
        -a system
}
notify () {
    brightness=$1
    notify-send -t 350 -u normal -a system \
        "backlight" "$brightness / $max_brightness" \
        -h string:x-canonical-private-synchronous:backlight
}

## logic to determine which action to take
case "$action" in
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
