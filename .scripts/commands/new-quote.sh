#!/bin/bash
# Mikey Garcia, @gikeymarcia
# capture jewels of wisdom (these also show up as random greetings)

# shellcheck source=/home/mikey/.bash_personal
. ~/.bash_personal

filename="$QUOTES/$(date -u +'%Y-%m-%dT%H-%M-%S--%Z').quote"
cp "$QUOTES/.template" "$filename"
$EDITOR "$filename"

# post-quote display and title input
author_stem=$(grep "^:by " "$filename" | sed -E 's/:by (.+)$/\1--/;s/ /./')
echo "$author_stem"
~/.scripts/commands/random-quote.sh "$filename"
echo "Input a title for the quote:"
read -r title

# rename based on given title
[ -z "$title" ] && echo "done" && exit
format_title=$(sed 's/ /_/g' <(echo "$title"))
echo "${QUOTES}/${author_stem}${format_title}.quote"
mv -v "$filename" "${QUOTES}/${author_stem}${format_title}.quote"
