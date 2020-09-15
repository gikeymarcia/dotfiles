#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dependencies: rsync openssh-client

# https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
# TODO make the repo push and pull @thelab
# https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server

src="$DLL"
user=mikey && host=thelab
if ! ping -c 1 -W 1 "$host" > /dev/null ; then
    echo "'$user@$host' UNAVAILABLE..."
    user=mikey && host=gikeymarcia.duckdns.org
fi
echo "backing up to '$user@$host'"
rsync -e ssh --info=progress2 -raul "$src" $user@$host:~/dll/ || \
    echo "backup failed"

# rsync flags
# --dry-run
# --info=progress2
# -e ssh
# --progress
