#!/bin/bash
# Mikey Garcia, @gikeymarcia
# build out a markdown directory into a corresponding directory of html files
# uses pandoc to convert the document
# dependencies: markdown-preview.sh fd

watch_dir=$1
if [ -n "$watch_dir" ]; then
    if [ ! -d "$watch_dir" ]; then
        echo "must pass a directory as first parameter"
    fi
else
    watch_dir="$HOME/.notes"
fi

out_dir=$2
[ -z "$out_dir" ] && out_dir="$HOME/.cache/my-notes"
rm -r "$out_dir" && mkdir -pv "$out_dir"

files=$(fd -e md . "$watch_dir" --color=never)

while IFS= read -r f; do
    dir=$(dirname "$f")
    new_dir=$(printf "%s" "$dir" | sed "s|^$watch_dir|$out_dir|")
    bare_name=$(basename "$f" .md)
    printf "%s\t%s\n" "input:" "$f"
    printf "%s\t%s\n" "output:" "$new_dir/${bare_name}.html"
    [ ! -d "$new_dir" ] && mkdir -pv "$new_dir"
    # echo "markdown-preview.sh '$f' '$new_dir/${bare_name}.html'"
    markdown-preview.sh "$f" "$new_dir/${bare_name}.html"
    echo " - - - - - - - - "
done <<< "$files"

tree "$out_dir"
du -sh "$out_dir"
