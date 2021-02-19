#!/bin/bash
# Mikey Garcia, @gikeymarcia
# pass an executable shell script and get an updating preview
# dependencies: entr

file=$1
dir=$(dirname "$file")
name=$(basename "$file")
if [ -f "$file" ] && [ -x "$file" ]; then
    echo "echo '$file' | entr -rpc '$dir/$name'" "$2" "$3"
    echo "$file" | entr -rpc "$dir/$name" "$2" "$3"
else
    [ ! -f "$file" ] && echo "'$file' is not a file."
    [ ! -x "$file" ] && echo "'$file' is not executable."
fi
