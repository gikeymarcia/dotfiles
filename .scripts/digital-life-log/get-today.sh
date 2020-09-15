#!/bin/bash
# Mikey Garcia, @gikeymarcia
# WORK-IN-PROGRESS

source ~/.bash_personal

# TODO more categories -- use resources file to generate links
now="devi"

time_dir="$DLL/plans/timeplan"
cd "$time_dir" || exit

if [ "$now" = "dev" ]; then
    echo "$(date): get today!"
    echo "--------"
    pwd
    ls -l
    echo "--------"
fi
shuf -n 1 "$time_dir/meditation.list"
