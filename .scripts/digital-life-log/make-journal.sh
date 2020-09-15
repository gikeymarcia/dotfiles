#!/bin/sh
# Mikey Garcia, @gikeymarcia
# open a vim buffer with a new joural entry
# shellcheck disable=SC2028,SC2016

t_stamp=$(date +"%Y.%m.%d--%H%M.journal.md")
renamed="$DLL/writing/journals/$(echo "$t_stamp" | sed "s .journal.md$ --f.journal.md  " )"
filename="$DLL/writing/journals/$t_stamp"

touch "$filename"
vim "$filename" -c ":set syntax=markdown"

wordcount=$(wc -w "$filename" | cut -d" " -f1)
if [ "$wordcount" -gt 1 ]; then
clear
    echo "Congratulations on your journal entry! Each day is a new beginning.\nDon't rest."
    echo "$(echo "$wordcount" | figlet -f small ) words written.\n"
    echo "mv -v $filename $renamed\n"
    echo "$filename\n"
else
    echo "nevermind." | figlet -f small
    rm -v "$filename"
fi
