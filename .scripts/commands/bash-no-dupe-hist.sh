#!/bin/bash
# https://unix.stackexchange.com/questions/48713/how-can-i-remove-duplicates-in-my-bash-history-preserving-order
hist=~/.bash_history

echo "line count: $(wc -l $hist)"
no_dupes=$(nl $hist | sort -k2 -k 1,1nr | uniq -f1 | sort -n | cut -f2)
echo "$no_dupes" > $hist
echo "new line count: $(wc -l $hist)"
