#!/usr/bin/env bash
#
# fzf preview contents for ~/.scripts/commands/bookmark-actions.sh
# Arguments:
#   ~/.config/bookmarks-dirs.dir entry (shrt /path/to/dir)

try_local_library () {
    library="$HOME/library"
    local_library="$HOME/local-library"
    printf "%s" "$1" | sed "s|^$library|$local_library|"
}

fzf_dir_preview () {
    ls -hF --color=always --group-directories-first "$1"
    echo "-!~-!~-!~-!~-!~-!~-!~-!~-!~-!~-!~-!~"
    tree -C -L 2 "$1"
}

missing_directory () {
    texts="nope M.I.A. K.I.A. R.I.P P.O.W. who-dat? huh?! 0_o? nah 404 lulz"
    msg=$(printf "%s" "$texts" | tr " " "\n" | shuf -n 1)
    figlet "$msg" | lolcat
    ~/.scripts/commands/random-quote.sh
}

[ -n "$1" ] && prev_path=$(echo "$1" | awk '{print $2}' | sed -E "s ^~ $HOME g")
if [ -d "$prev_path" ]; then
    fzf_dir_preview "$prev_path"
else
    local_library=$(try_local_library "$prev_path")
    if [ -d "$local_library" ]; then
        fzf_dir_preview "$local_library"
    else
        missing_directory
    fi
fi
