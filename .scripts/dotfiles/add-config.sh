#!/bin/sh
# Mikey Garcia, @gikeymarcia
# OLD-script, earlier version of script to add modified files into dotfiles
# shellcheck disable=SC2016,SC2129

# script variables
config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME"
patch_dir="$HOME/.config-patches"
patch_name="$patch_dir/newest.patch"
add_name="$patch_dir/adds.sh"

cd "$HOME" || exit

# make script to add all new files
added=$($config status -s | grep ^A | awk '{print $2}' | sed 's/^/$config add -- /')
echo "#!/bin/bash" > "$add_name"
echo 'cd "$HOME" || exit' >> "$add_name"
echo 'config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME"' >> "$add_name"
echo "$added" >> "$add_name"
chmod +x "$add_name"
cat "$add_name"


# checkout files that randomly change
$config checkout -- .config/deluge/gtkui.conf


# archive old patches
if [ -f "$patch_name" ]; then
    if [ ! -d "$patch_dir" ]; then mkdir "$patch_dir"; fi
    mv "$patch_name" "$patch_dir/$(date -u +'%Y-%m-%dT%H:%M:%S').patch"
fi


# add and make patch file
$config add -u
$config diff -P HEAD > "$patch_name"


# view patch in $EDITOR
$EDITOR -R "$patch_name"

# output status and filename
$config status -s
current_branch="$($config status | grep "On branch" | awk '{ print $3 }')"
echo "current branch:"
echo "$current_branch" | figlet | lolcat -d 2
echo "patch_file: $patch_name"
echo "add-file: $add_name"
