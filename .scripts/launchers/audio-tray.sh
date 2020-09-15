#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch system tray volume manager

# IDEA use qtile widget instead

# Terminate already running applet instances
~/.scripts/commands/nice_shutdown.sh pasystray

pasystray &
