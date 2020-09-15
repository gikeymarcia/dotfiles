#!/bin/bash
# Mikey Garcia, @gikeymarcia

# shellcheck source=/home/mikey/.bash_personal
. ~/.bash_personal

# copy new-word template and edit in vim
template="$WORDS/.template"
filename="$WORDS/$(date -u +'%Y-%m-%dT%H-%M-%S--%Z').word"
cp "$template" "$filename"
$EDITOR "$filename"

# delete the file if unmodified
cmp --silent "$template" "$filename" && rm -v "$filename" && exit

# rename temporary file to reflect entered word
word_stem=$(grep "^:word " "$filename" | sed -E 's/:word (.*)$/\1/;s/ /_/g')
new_name="${WORDS}/${word_stem}.word"
mv -v -n "$filename" "$new_name"
