#!/bin/bash
# Mikey Garcia, @gikeymarcia
# get battery info
# dependencies:


battery="BAT0"
#cat /sys/class/power_supply/BAT0/capacity
status=$(cat "/sys/class/power_supply/$battery/status")
full=$(cat "/sys/class/power_supply/$battery/charge_full")
now=$(cat "/sys/class/power_supply/$battery/charge_now")

charge=$(echo "scale = 3; ($now/$full)*100" | bc)

printf "%s\n\n%s percent charged\n" "$status" "$charge"
