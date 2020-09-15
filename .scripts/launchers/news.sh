#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu chooser for news sources to pull up
# dependencies: dmenu brave-browser

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

sources+=("Twitter                  https://twitter.com/i/lists/1262742821989019649")
sources+=("NewDiscourses            https://newdiscourses.com/")
sources+=("AOUnityPhoenix           https://twitter.com/AoUnityPhoenix")
sources+=("MarginalRevolution       https://marginalrevolution.com")
sources+=("ArticlesOfUnity          https://discuss.articlesofunity.org")
sources+=("IQAir                    https://www.iqair.com/us/air-quality-map?lat=34.09836&lng=-117.92383&zoomLevel=10")

choices () {
    for link in "${sources[@]}"; do echo "$link"; done
}

# shellcheck disable=SC2086
sel="$(choices | dmenu -i -l 20 $DMENU_COLORS -fn "$DMENU_FONT" \
       -p 'What to read next? ' )"
if [ -n "$sel" ]; then
    url=$(printf "%s" "$sel" | awk '{print $2}' )
    brave-browser --incognito "$url"
fi
