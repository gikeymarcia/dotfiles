#!/bin/bash
# Mikey Garcia, @gikeymarcia
# actions for interacting with my dotfiles and associated git repo
# dependencies: fzf ack $DOTFILES $EDITOR
# dependencies: dotfile_paths.sh edit-config-file.sh get_clip.sh fzf-preview.sh

# shellcheck source=/home/mikey/.bash_personal
source ~/.bash_personal

# preparing the grounds
cd ~ || exit
[ -d "$DOTFILES" ] || exit
action=$1
export config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME/"

# development use / default action
[ -z "$1" ] && action="status"

# functions
my_branch (){
    $config branch --show-current
}
paths (){
    ~/.scripts/dotfiles/dotfile_paths.sh full
}
case "$action" in
# git
    "status" )
        $config branch -a
        figlet "$(my_branch)" | lolcat
        $config status -s
        ;;
    "edit" )
        ~/.scripts/dotfiles/edit-config-file.sh
        ;;
    "paths" )
        paths
        ;;
    "add" )
        # add modified
        [ -z "$2" ] && $config add -u -v
        [ -f "$2" ] && $config add -v -- "$2"
        ;;
    "commit" )
        $config commit
        ;;
    "diff" )
        $config diff -P HEAD
    ;;
    "log" )
        $config log --oneline -n 20
    ;;
    "raw" )
        ~/.scripts/commands/get-clip.sh "$config"
    ;;
    "tar" )
        cd ~ || exit
        paths | sed "s|^$HOME/||g" | sed -E "s/^(.*)$/'\1'/" | xargs \
            tar cvzf con-ball.tar.gz
        file ~/con-ball.tar.gz
        du ~/con-ball.tar.gz
    ;;
# functionality
    "search" )
        # preview file if no search term given
        if [ -z "$2" ]; then
            selection=$(paths | fzf \
                --preview="$HOME/.scripts/dotfiles/fzf-preview.sh {}" )
            [ -n "$selection" ] && printf "%s" "$selection" | xargs bat
        else
            # `ack $REGEX` search through dotfiles. Opens selection in vim
            hits=$(paths | ack -x -l "$2")
            file=$(printf "%s" "$hits" | fzf \
                --preview="grep --line-number $2 {} && $HOME/.scripts/dotfiles/fzf-preview.sh {}")

            [ -z "$file" ] && echo "selection cancelled." && exit
            # open in $EDITOR with search applied
            [ -r "$file" ] && $EDITOR -c "/$2" "$file"
            # shellcheck disable=SC2046
            [ ! -r "$file" ] &&
                $EDITOR -c "/$2" -o $(printf "%s" "$file" | tr "\n" " ")
        fi
    ;;
    * ) echo "'$1' is not an option."
esac
