#!/bin/bash
# Mikey Garcia, @gikeymarcia
# fzf choose from a bookmark file @ ~/.config/bookmarks-dirs.dirs
# moves you to that directory either in the shell or with a file manager
# dependencies: fzf bookmark-paths.sh bookmark-preview.sh
# environment: $FILE_MANAGER $EDITOR

# TODO default behavior should jump to dir then offer fzf search to descend
#      deeper into the directory structure. Really useful for pointing at a
#      project and immediately jumping down to a subsection of the project
# TODO expand this thing to do lots of stuff
# bm mv = move to bookmark
# bm shell = search to
# bm editor = launch editor at bookmark
# bm ranger = launch ranger at bookmark

selection=$(
    bookmark-paths.sh | sort -k 2 |
    fzf --tiebreak=begin,length,end,index --height=100% \
        --no-multi --preview="bookmark-preview.sh {}" |
    awk '{print $2}' | sed "s ^~ $HOME "
)

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
