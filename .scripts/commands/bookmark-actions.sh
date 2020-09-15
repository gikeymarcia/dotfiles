#!/bin/bash
#
# fzf choose from a bookmark file @ ~/.config/bookmarks-dirs.dirs
# moves you to that directory either in the shell or with a file manager

# TODO expand this thing to do lots of stuff
# bm mv = move to bookmark
# bm shell = search to
# bm editor = launch editor at bookmark
# bm ranger = launch ranger at bookmark

selection=$(
    ~/.scripts/sys-info/bookmark_paths.sh | sort -k 2 |
    fzf --height=100% --preview="~/.scripts/commands/bookmark-preview.sh {}" |
    awk '{print $2}' | sed "s ^~ $HOME "
)

try_local_library () {
    if [ -d "$1" ]; then
        printf "%s" "$1"
    else
        library=~/library
        local_library=~/local-library
        printf "%s" "$1" | sed "s|^$library|$local_library|"
    fi
}
selection=$(try_local_library "$selection" )

if [ -d "$selection" ]; then
    printf "from:\t%s\n" "$(pwd)"
    cd "$selection" || exit

    [ "$1" = "shell" ] && ls -lhHF --color=always --group-directories-first
    printf "to:\t%s\n\n" "$(pwd)"
    [ -z "$1" ] && $FILE_MANAGER
    [ "$1" = "editor" ] && $EDITOR
else
    echo "missing directory."
    echo "$selection"
fi
