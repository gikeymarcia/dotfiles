#!/bin/bash
# Mikey Garcia, @gikeymarcia
# cd terminal to the result of a script
# usage:
#  alias jump="source move-term.sh my-decider-script.py"
#  $ jump  -> script returns result -> cd "$result"

script=$1
param1=$2
param2=$3
location=$( "$script" "$param1" "$param2" )
echo "$location"
if [ -d "$location" ]; then
    cd "$location" || echo "Could not cd to $location"
    tree -L 2
    ls --color=auto --group-directories-first -hFH
else
    echo "$location is not a directory on $(hostname)"
fi
