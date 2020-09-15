#!/bin/bash
# Mikey Garcia, @gikeymarcia
# returns paths to all files in dotfiles repo
#  includes new files staged for commit
#  removes renamed and marked for deletion files
# dependencies: git $DOTFILES

source ~/.bash_personal


cd ~ || exit
# make shortcut to address the dotfiles repo
config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME"
export config

# existing repo files
status_s=$($config status -s)
in_repo=$($config ls-tree --full-tree --full-name -r HEAD |
    sed -E 's/^[0-9]+\ [a-z]+\ [a-z,0-9]+[ \t\n\r\f\v]+//' )
    # echo "$in_repo"
    # exit
new_adds=$(printf "%s" "$status_s" | grep -E ^A | awk '{print $2}' )
renamed_to=$(printf "%s" "$status_s" | grep "^R.*$" |
    sed -E "s/^R .* -> (.*)$/\1/" )
all=$( printf "%s\n%s\n%s" "$in_repo" "$new_adds" "$renamed_to")

# trim out deleted files
deleted=$(printf "%s" "$status_s" | grep ^D | sed -E "s/^D +(.*)$/\1/g")
if [ -n "$deleted" ]; then
    while IFS= read -r del; do
        regex=$(echo "$del" | sed -E "s/\./\\\./g" | sed 's/"//g')
        all=$(grep -v "$regex" <(echo "$all"))
        #echo "$all" | wc -l
    done <<< "$deleted"
fi

    #echo "$all" | wc -l

# trim out old file locations
old_loc=$(printf "%s" "$status_s" | grep "^R" | sed -E "s/^R +(.*) ->.*$/\1/")
if [ -n "$old_loc" ]; then
    while IFS= read -r old; do
        regex=$(echo "$old" | sed -E "s/\./\\\./g")
        all=$(grep -v "$regex" <(echo "$all"))
    done <<< "$old_loc"
fi

# delete blank lines
all=$(printf "%s" "$all" | sed '/^$/d' | sort)

# final sed quote wraps any paths with spaces
[ -z "$1" ] && printf "%s\n" "$all" | sed -E 's/^([^ ]+ [^ ]+.*)$/"\1"/'
[ "$1" = "full" ] && printf "%s\n" "$all" | sed "s ^ $HOME/ " |
    sed -E 's/^([^ ]+ [^ ]+.*)$/"\1"/'
