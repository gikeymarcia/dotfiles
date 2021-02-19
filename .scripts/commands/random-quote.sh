#!/bin/bash
# Mikey Garcia, @gikeymarcia
# display a formatted quote from $QUOTES directory
# dependencies: cowsay fd
# environment: $QUOTES

max_words=450
wrap_len=60
padding="  "

if [ -r "$1" ]; then
    quote=$1
else
    [ ! -d "$QUOTES" ] && exit
    ## choose random quote
    files=$(fd --type f . "$QUOTES")
    maybe=$(shuf -n 1 <(printf "%s\n" "$files"))
    while [ "$(wc -w "$maybe" | cut -d" " -f 1)" -gt "$max_words" ]; do
        maybe=$(shuf -n 1 <(printf "%s\n" "$files") )
    done
    quote=$maybe
fi

# shellcheck disable=SC2002
trimmed_quote=$( cat "$quote" |
    sed "/^:context$/d" |
    sed "/^:tags$/d" |
    sed "/^:link$/d" |
    sed "/^:date$/d" |
    sed "/^:from$/d"
)
processed_quote=$(printf "%s" "$trimmed_quote" |
    sed "s ^:by ~ " |
    sed "s ^:from\s  "  |
    sed "s|^:context|\nthe context:|" |
    sed "s :link\n  " |
    sed "s :date\s  "
)

if [ "$1" = "lol" ]; then
    cowpath=~/.config/cowsay/cows
    randcow=$(fd -e cow . "$cowpath" | shuf -n 1)
    cowsay -W "$wrap_len" -f "$randcow" "$processed_quote" | lolcat -F 0.05
else
    printf "\n%s\n" "$processed_quote" |
        fold -s -w "$wrap_len" | sed "s/^/$padding/"
fi
printf "\n\n\n%s\n\n\n" "$quote" | sed "s|^$QUOTES|$padding\$QUOTES|"
[ "$1" = "lol" ] && printf "\n%s\n" "$randcow"
