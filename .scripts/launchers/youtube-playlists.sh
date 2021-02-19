#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch browser directly into a youtube playlist
# dependencies: brave-browser dmenu
# environment: $DMENU_FONT $DMENU_COLORS
# TODO -- turn this into python

# list of short names and associated youtube playlist URLs
playlists+=("Now!                      https://www.youtube.com/playlist?list=PLpJPyYfmqUWyUm2cLj9g-ZRwR4SzOXWab")
playlists+=("Sound_Shields             https://www.youtube.com/playlist?list=PLpJPyYfmqUWwlm9XejjZEGpXjEVxAKCkw")
playlists+=("Podcast_Q                 https://www.youtube.com/playlist?list=PLpJPyYfmqUWxhA8hzu6-1RvQA9sgANm1Q")
playlists+=("Game~B                    https://www.youtube.com/playlist?list=PLpJPyYfmqUWxCx0cofc3TbkesXMerxfPu")
playlists+=("Linux_Guides              https://www.youtube.com/playlist?list=PLpJPyYfmqUWxOslaP4J4QR19W3frR9c25")
playlists+=("Linux_Q                   https://www.youtube.com/playlist?list=PLpJPyYfmqUWwFDQRvzPVXJh2s49kN5YAl")
playlists+=("Yoga_Q                    https://www.youtube.com/playlist?list=PLpJPyYfmqUWwy0Hx9H00TssUDejdmXlMI")
playlists+=("Meditation_Q              https://www.youtube.com/playlist?list=PLpJPyYfmqUWzLZ3pyIYW74n3qgZQq5g3i")
playlists+=("Upon_Waking_Up            https://www.youtube.com/playlist?list=PLpJPyYfmqUWwXld2xZ9JF0_PTZc0PvvdN")
playlists+=("Dharma_Q                  https://www.youtube.com/playlist?list=PLpJPyYfmqUWywmVbpwFsr8c_WHkvFOWhE")
playlists+=("SciNerd_Q                 https://www.youtube.com/playlist?list=PLpJPyYfmqUWwEbcootVaPmx4aq_Vt-8rz")
playlists+=("Gigi                      https://www.youtube.com/playlist?list=PLpJPyYfmqUWwJ9SwDkNGLqOR6MrknyVOR")
# courses / topics
playlists+=("MissingSemester           https://www.youtube.com/playlist?list=PLyzOVJj3bHQuloKGG59rS43e29ro7I57J")
playlists+=("Linear_Algebra_course     https://www.youtube.com/playlist?list=PL49CF3715CB9EF31D")
playlists+=("Essence_of_linear_algebra https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab")

yt_pls () {
    for name in "${playlists[@]}"; do echo "$name"; done
}

# shellcheck disable=SC2086
selection="$(
    yt_pls | awk '{print $1}' | sed 's/_/ /g' |
    dmenu -i -l 20 $DMENU_COLORS \
        -fn "$DMENU_FONT" \
        -p "Which youtube playlist do you need?" |
    sed 's/ /_/g'
)"

if [ -n "$selection" ]; then
    url=$(grep "^$selection" <(yt_pls) | awk '{print $2}')
    brave-browser --app="$url"
fi
