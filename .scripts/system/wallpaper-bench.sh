#!/bin/sh
# Mikey Garcia, @gikeymarcia
# takes parameter values of "bench" or "play"
# "bench" -- wallpapers OUT of rotation
# "play"  -- wallpapers INTO rotation
# -z $1   -- fzf action chooser
# dependencies: sxiv fd


action=$1
[ ! -d "$WALLPAPERS" ] && WALLPAPERS=~/local-library/pictures/wallpapers
# needed directories
the_bench="$WALLPAPERS/on-the-bench"
[ ! -d "$WALLPAPERS" ] && echo "$WALLPAPERS: doesn't exit." && exit
[ ! -d "$the_bench" ] && echo "$the_bench: doesn't exit." && exit
# choose action
if [ -z "$action" ]; then
    action=$(printf "%s\n%s\n" \
        "bench -- REMOVE wallpapers from rotation" \
        "play  -- ADD    wallpapers into rotation"  | fzf \
        --prompt="what do you want to do?")
    [ -z "$action" ] && echo "selection cancelled." && exit
    action=$(printf "%s" "$action" | sed -E "s/^([^ ]+).*$/\1/")
fi

move_wallpapers () {
    fd -d 1 -e jpg -e jpeg -e png . "$1" | shuf | sxiv -tof - |
        sed 's ^ " ;s $ " ' |  xargs --no-run-if-empty mv -v -t "$2"
}
[ "$action" = "bench" ] && move_wallpapers "$WALLPAPERS" "$the_bench"
[ "$action" = "play"  ] && move_wallpapers "$the_bench" "$WALLPAPERS"
