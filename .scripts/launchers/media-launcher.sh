#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu picker for media sources
# dependencies: dmenu brave-browser

. ~/.bash_env

media+=("plx     Plex               https://app.plex.tv/desktop#")
media+=("pod     PocketCasts        https://play.pocketcasts.com/podcasts")
media+=("mus     youtube-music      https://music.youtube.com/")
media+=("yt      Youtube            https://www.youtube.com/feed/subscriptions")
media+=("sp      Spotify            https://open.spotify.com/browse/featured")

all_media () {
    for m in "${media[@]}"; do echo "$m"; done
}

# shellcheck disable=SC2086
sel=$(all_media | sed -E "s/http.*$//g" |
    dmenu -l 20 -i $DMENU_COLORS -fn "$DMENU_FONT" \
    -p "Havin' fun time?")
if [ -n "$sel" ]; then
    url=$(all_media | grep "^$sel" | awk '{print $3}')
    brave-browser --app="$url"
fi
