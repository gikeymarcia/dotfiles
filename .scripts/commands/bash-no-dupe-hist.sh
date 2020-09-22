#!/bin/bash
# Mikey Garcia, @gikeymarcia
# remove duplicate items from the ~/.bash_history
hist=~/.bash_history

echo "line count: $(wc -l $hist)"
# https://unix.stackexchange.com/a/48716
no_dupes=$(nl $hist | sort -k2 -k 1,1nr | uniq -f1 | sort -n | cut -f2)
echo "$no_dupes" > $hist
echo "new line count: $(wc -l $hist)"
