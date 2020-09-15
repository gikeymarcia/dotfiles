#!/bin/sh
# Mikey Garcia, @gikeymarcia
# change system volume and present a notification
# dependencies: libnotify-bin pulseaudio-ctl

command="$1"

report_volume () {
    # -h in notify-send is so each nofication replaces the previous
    # https://askubuntu.com/a/871207
    status="$(pulseaudio-ctl full-status)"
    vol=$(printf "%s" "$status" | awk '{print $1}')
    muted=$(printf "%s" "$status" | awk '{print $2}')
    length=1500
    if [ "$muted" = "yes" ]; then
        notify-send -t $length -a system "Volume" "MUTED @ $vol" \
            -h string:x-canonical-private-synchronous:system-volume
    else
        notify-send -t $length -a system "Volume" "$vol" \
            -h string:x-canonical-private-synchronous:system-volume
    fi
}

case "$command" in
    up )
        pulseaudio-ctl up
        report_volume
    ;;
    down )
        pulseaudio-ctl down
        report_volume
    ;;
    mute )
        pulseaudio-ctl mute
        report_volume
    ;;
esac
