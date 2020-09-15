#!/bin/bash
# Mikey Garcia, @gikeymarcia
# patch current branch of dotfile repo to match the param '$1' branch
# dependencies: nvim git

# shellcheck disable=SC2086

# script env
cd "$HOME" || exit 1
there=$1
patch="$HOME/here2there.diff"
config="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
here_branch=$($config branch --show-current)

# check $there is a real branch
[ -z "$1" ] && echo "missing paramter: pulling from branch" && exit
if ! $config branch --list | grep "..$there$" > /dev/null ; then
    echo "no such branch as '$there'." && exit
fi

# make patch file
$config diff -p "$here_branch" "$there" > "$patch"

# delete removed binary files
#del_bin=$(grep -E "^Binary files a.* and /dev/null differ$" "$patch" |
#    sed -E "s/^Binary files a\/(.*) and \/dev\/null.*$/\1/")
#[ -n "$del_bin" ] && printf "%s" "$del_bin" | xargs -I _ rm -v '_'

# edit patch then apply patch
nvim "$patch"
patch -p1 < "$patch"

# checkout files that shouldn't change
manual_checkout+=(".Xresources")
manual_checkout+=(".config/deluge/core.conf")
manual_checkout+=(".config/deluge/gtkui.conf")
manual_checkout+=(".config/dunst/dunstrc")
manual_checkout+=(".config/polybar/config")
manual_checkout+=(".gtkrc-2.0")
for f in "${manual_checkout[@]}"; do
    #continue
    $config checkout "$here_branch" -- $f
done

# checkout new files from branch
new_files=$(grep -B 1 "^new file mode" "$patch" | grep ^diff |
    sed -E "s/^diff --git a\/(.*) b\/.*$/\1/")
new_binary=$(grep -E "^Binary files /dev/null and b/.*$" "$patch" |
    sed -E "s/^.* and b\/(.*) differ/\1/")
if [ -n "$new_files" ] || [ -n "$new_binary" ]; then
    both=$(printf "%s\n%s\n" "$new_files" "$new_binary")
    printf "%s" "$both" | xargs -I _ $config checkout $there -- _
    printf "%s" "$both" | xargs -I _ $config add -v -- _
fi
# stage all modifications
$config add -u -v
