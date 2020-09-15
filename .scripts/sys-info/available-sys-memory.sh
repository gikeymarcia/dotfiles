#!/bin/sh
# Mikey Garcia, @gikeymarcia
# see free memory
# dependencies:

freeline=$( free -m | grep Mem )
used=$( echo "$freeline" | awk '{print $7}')
total=$( echo "$freeline" | awk '{print $2}')
echo "$used / ${total}mbs free."
