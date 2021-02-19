#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# dmenu quick selector to begin watson project
# dependencies: watson dmenu
# environment: $DMENU_COLORS $DMENU_FONT

import subprocess
import dmenu
import os
import pprint


def dmenu_colors():
    # https://dmenu.readthedocs.io/en/latest/
    dmcolor = os.environ.get('DMENU_COLORS').split(" ")

    def color_val(flag):
        return dmcolor[dmcolor.index(flag) + 1]
    return {
        "foreground_selected": color_val('-sf'),
        "background_selected": color_val('-sb'),
        "foreground": color_val('-nf'),
        "background": color_val('-nb'),
    }


def run(command):
    return subprocess.run(command, capture_output=True, text=True).stdout


pp = pprint.PrettyPrinter(indent=4, width=80, compact=True, sort_dicts=False)
p = pp.pprint
projects = run(['watson', 'projects']).split()
options = projects + ['STOP', 'STATUS']
colors = dmenu_colors()
choice = dmenu.show(options,
                    case_insensitive=True,
                    font=os.environ.get('DMENU_FONT'),
                    prompt="Pick project!",
                    **colors)
if choice in options:
    if choice == "STOP":
        subprocess.run(['watson', 'stop'])
        # working on logs
        # report = run(['watson', 'log', '--json'])
        # log out
    elif choice == "STATUS":
        now = run(['watson', 'status', '-p']).strip()
        time = run(['watson', 'status', '-e']).strip()
        subprocess.run(['notify-send', '-t', '2500', '-a',
                        'watson', now, "started {}".format(time)])
        # p([now, time])
    elif choice in projects:
        subprocess.run(['watson', 'start', choice])
else:
    msg = ("'{}' project does not exist in watson.\n"
           "To create project run 'watson start {}'\n")
    print(msg.format(choice, choice))
