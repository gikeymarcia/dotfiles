#!/bin/bash
# Mikey Garcia, @gikeymarcia
#
# dependencies: dotfile_paths.sh $filter

stem_filter () {
    escape_dot=$(printf "%s" "$1" | sed "s \. \. g")
    grep -v "^$escape_dot" <(printf "%s" "$2")
}
filter=~/.config/filter-dotfiles/privatemask.list
if [ -s "$filter" ]; then
    # https://unix.stackexchange.com/a/299465
    safe=$(grep -F -v -x -f $filter <(dotfile_paths.sh))
    no_notes=$(stem_filter ".notes/" "$safe")
    no_ssh=$(stem_filter ".ssh/" "$no_notes")
    no_deluge=$(stem_filter ".config/deluge" "$no_ssh")
    printf "%s" "$no_deluge"
else
    # https://stackoverflow.com/a/23550347
    >&2 echo "cannot find mask to filter dotfiles."
    >&2 echo "searched @ '$filter'"
    exit 1
fi
