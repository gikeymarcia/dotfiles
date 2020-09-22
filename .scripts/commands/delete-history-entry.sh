#!/bin/bash
# Mikey Garcia, @gikeymarcia
# use fzf to remove entries from bash history
# dependencies: fzf figlet
# environment:
#   note: you have to source this script from bash. I do this with an alias--
#         alias rhist='source ~/.scripts/commands/delete-history-entry.sh'

entry=$(history | grep -v "\*" | fzf --height=90% --tac +m)
if [ -z "$entry" ] ; then
    echo "no selection made."
else
    selected_cmd=$(printf "%s" "$entry" | sed -E "s/[ 0-9]+[ ]+(.*)$/\1/g")
    figlet "matching entries"
    while history | grep -E "^[0-9 ]+$selected_cmd\$" > /dev/null ; do
        line=$(history | grep -E "^[0-9 ]+$selected_cmd\$" | head -n 1)
        line_num=$(printf "%s" "$line" |
            sed -E "s/ *([0-9]+).*$/\1/g" | head -n 1)
        printf "deleting from history:  %s\n" "$line"
        #printf "match found!:  %s\n" "$line"
        #echo "deleting line $line_num from history"
        history -d "$line_num"
        #sleep 1
    done
    history -w
    history -r
fi
