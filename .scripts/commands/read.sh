#!/bin/bash
# Mikey Garcia, @gikeymarcia
# wraps a file and displays it in less for reading

item=$1
wrap_len=85

text=$(fold -s -w "$wrap_len" < "$item")

pr -T -o 15 <( printf "\n\n%s" "$text" ) | less
