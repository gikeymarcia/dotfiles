#!/bin/sh
# Mikey Garcia, @gikeymarcia
# a reminder: the terminal equivalent of a bright post-it note

# figlet font choice
fig_font="big"

# starting timestamp
begin=/tmp/shout-start.time
[ -f $begin ] && rm -v $begin
date > $begin

header="start:  $(cat "$begin")\n"
message=$(echo "$@" | sed "s -- \n g" | figlet -f "$fig_font" )
while true; do
    clear
    footer="\nstamp:  $(date)"
    echo "$header$message$footer" | lolcat
    sleep 60
done
