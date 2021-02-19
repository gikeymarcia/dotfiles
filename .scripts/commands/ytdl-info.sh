#!/bin/bash
# Mikey Garcia, @gikeymarcia
# download information about how youtube-dl will treat a video
# dependencies: youtube-dl jq

vid=$1

printf "\n\n---%s\n" "$vid"
youtube-dl --ignore-config --list-formats "$vid"
printf "\n%s\n" '---Format that will be downloaded'
youtube-dl --get-format "$vid"
printf "\n%s\n" '---More info'
jq "._fullname, .extractor, .uploader, .fulltitle, .webpage_url, .format, .vcodec, .tbr" \
    <(youtube-dl --dump-json "$vid")

#jq "." <(youtube-dl --ignore-config --dump-json "$vid")
exit
