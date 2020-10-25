#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu chooser for news sources to pull up
# dependencies: dmenu brave-browser

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

sources+=("Twitter              https://twitter.com/i/lists/1262742821989019649")
sources+=("NewDiscourses        https://newdiscourses.com/")
sources+=("Game~B~Library       https://www.gameblibrary.com/")
sources+=("BonnittaRoy          https://medium.com/@bonnittaroy")
sources+=("Game~B~Wiki          https://www.gameb.wiki/index.php?title=Main_Page")
sources+=("CivilizationEmerging https://civilizationemerging.com/")
sources+=("AOUnityPhoenix       https://twitter.com/AoUnityPhoenix")
sources+=("MarginalRevolution   https://marginalrevolution.com")
sources+=("Unity~discuss        https://discuss.articlesofunity.org")
# sources+=("IQAir                https://www.iqair.com/us/air-quality-map?lat=34.05836&lng=-118.02883&zoomLevel=11")

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
