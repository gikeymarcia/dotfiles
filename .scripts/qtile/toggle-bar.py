#!/usr/bin/env python
# Mikey Garcia, @gikeymarcia
# toggle visibility of qtile bars
# dependencies: qtile
# environment: $EDITOR

# http://docs.qtile.org/en/latest/manual/ref/commands.html
from libqtile.command_client import InteractiveCommandClient
c = InteractiveCommandClient()
c.hide_show_bar(position="all")
