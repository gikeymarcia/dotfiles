#!/bin/sh
# Mikey Garcia, @gikeymarcia
# use sshfs to mount my server:$HOME/library
# dependencies: sshfs

# only attempt when remote
[ "$(hostname)" = "thelab" ] &&
    echo "You are already sitting @thelab. aborting mount." && exit 1

src=/home/mikey/library
target=~/library
# look for machine locally, then fallback to internet pathing
if [ -z "$1" ] ; then
    user=mikey && host=thelab
    if ! ping -c 1 -W 1 "$host" > /dev/null ; then
        echo "'$user@$host' UNAVAILABLE..."
        user=mikey && host=gikeymarcia.duckdns.org
    fi
    echo "mounting filesystem from '$user@$host'"
    sshfs $user@$host:$src $target
else
    sudo umount $target
fi
