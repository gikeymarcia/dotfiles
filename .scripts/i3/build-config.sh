#!/bin/sh
# Mikey Garcia, @gikeymarcia
# combine master and branch specific pieces of i3 config together

cfg_dir="$HOME/.config/i3"
master="$cfg_dir/master-config"
thelab="$cfg_dir/desktop-config"
macbook="$cfg_dir/laptop-config"
live="$cfg_dir/config"

if [ "$(hostname)" = "macbook" ]; then
    cat "$master" "$macbook" > "$live"
elif [ "$(hostname)" = "thelab" ]; then
    cat "$master" "$thelab" > "$live"
fi
ls -lh "$live"

# reload on edit
if pgrep i3 > /dev/null ; then
    i3-msg reload
fi
