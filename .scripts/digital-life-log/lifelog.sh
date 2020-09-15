#!/bin/bash
# Mikey Garcia, @gikeymarcia
# tool to manage, search, backup, and version control my lifelog
# shellcheck disable=SC2086

action=$1
echo $action
# for development use
[ -z "$1" ] && action="status"
# shellcheck source=/home/mikey/.bash_personal
. ~/.bash_personal

[ -d "$DLL" ] || exit
life="/usr/bin/git --git-dir=${DLL}/.git --work-tree=${DLL}"
days="$DLL/plans/days"
case "$action" in
    # git stuff
    "status" )
        figlet digital-life-log | lolcat
        $life status -s
    ;;
    "add" )
        # add modified
        $life add -u -v
        # add untracked
        figlet -f digital untracked
        $life status -s | grep "^?? " | sed -E 's|^\?\? (.*)$|\1|g' |
            xargs $life add -v --
    ;;
    "commit" )
        $life commit
    ;;
    "diff" )
        $life diff -P HEAD
    ;;
    "log" )
        $life log
    ;;
    "raw" )
        echo "$life"
    ;;
    # functionality
    "backup" )
        "$DLL/scripts/rsync-backup.sh"
    ;;
    "quote" )
        "$DLL/scripts/random-quote.sh"
    ;;
    "sq" )
        "$DLL/scripts/search-quotes.sh" "$2"
    ;;
    "search" )
        "$DLL/scripts/search-log.sh"
    ;;
    "days" )
        choice="$days/$(
            cd "$days" || exit
            fd -t f -e md . . | sort |
                fzf --no-multi --tac --prompt="choose a file to open" \
                --preview="$HOME/.scripts/dotfiles/fzf-preview.sh {}"
        )"
        [ -r "$choice" ] && $EDITOR "$choice"
    ;;
    "new day" )
        choice="$days/$(
            cd "$days" || exit
            fd -H -t f -e md . . | sort |
                fzf --no-multi --tac \
                --prompt="Which day do you want to copy from?"
        )"
        datestamp=$(date --date="next day" "+%Y-%m-%d")

        # TODO -- let me choose between tomorrow and today
            #tomorrow=$(date --date="next day" "+%Y-%m-%d")
            #today=$(date "+%Y-%m-%d")

        echo "ttle for $datestamp:"
        read -r name
        format_name=$(printf "%s" "$name" | sed "s/ /_/g")
        fullname="$days/$datestamp--$format_name.day.md"
        cp -v "$choice" "$fullname"
        $EDITOR "$fullname"
    ;;
esac
