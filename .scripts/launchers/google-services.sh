#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu select a google service and open in the brave-browser

# shellcheck source=/home/mikey/.bash_env
. ~/.bash_env

sites+=("c      calendar           https://calendar.google.com/calendar/r")
sites+=("m      gmail              https://mail.google.com/mail/u/0/#inbox")
sites+=("k      keep               https://keep.google.com/u/0/")
sites+=("g      google             https://www.google.com/")
sites+=("p      contacts(people)   https://contacts.google.com/")
sites+=("ph     Photos             https://photos.google.com/")
sites+=("i      google(incognito)  https://www.google.com/")
sites+=("ma     maps               https://www.google.com/maps")
sites+=("fd     find-my-device     https://www.google.com/android/find?u=0")
sites+=("dr     GoogleDrive        https://drive.google.com/drive/u/0/recent")
sites+=("doc    GoogleDocs         https://docs.google.com/document/u/0/")
duh_googs () {
    for line in "${sites[@]}"; do echo "$line" ; done;
}

# shellcheck disable=SC2086
selection=$(duh_googs | sed "s/\s*http.*$//" |
    dmenu -i -l 12 $DMENU_COLORS \
    -fn "$DMENU_FONT" \
    -p "peer into the all-seeing eye..."
)

if [ -n "$selection" ]; then
    URL=$(duh_googs | grep "^$selection.*$" | awk '{print $3}')
    if grep -q incognito <(echo "$selection"); then
        brave-browser --incognito --app="$URL"
    else
        brave-browser --app="$URL"
    fi
fi
