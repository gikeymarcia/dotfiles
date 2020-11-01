#!/usr/bin/env python
# Mikey Garcia, @gikeymarcia config for qtile v0.16.0
# development: view logs with
# tail -f ~/.local/share/qtile/qtile.log
# docs @ http://docs.qtile.org/en/latest/manual/config/index.html
import os
import subprocess
from typing import List  # noqa: F401
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.lazy import lazy
from libqtile import hook
#                                  _                    __ _
#   __ _  ___ _ __   ___ _ __ __ _| |   ___ ___  _ __  / _(_) __ _
#  / _` |/ _ \ '_ \ / _ \ '__/ _` | |  / __/ _ \| '_ \| |_| |/ _` |
# | (_| |  __/ | | |  __/ | | (_| | | | (_| (_) | | | |  _| | (_| |
#  \__, |\___|_| |_|\___|_|  \__,_|_|  \___\___/|_| |_|_| |_|\__, |
#  |___/                                                     |___/
# env
terminal = "alacritty"
mod = "mod4"
auto_fullscreen = True
cursor_warp = False
focus_on_window_activation = "smart"
follow_mouse_focus = False
bring_front_click = True


# shorthand for launching my scripts and accepting parameters
def script(syspath, param=None):
    if param is None:
        return os.path.expanduser(syspath)
    else:
        return str(os.path.expanduser(syspath) + " " + param)


# UI settings
my = {
    "font": "JetBrainsMono Nerd Font Mono",
    "fontsize": 20,
    "margin": 10,
    "border_width": 5,
    "bar_height": 40,
}
# colors
clr = {
    "urgent": "#cc0000",
    "background": "#000000",
    "foreground": "#ffffff",
    "fg_dim": "#ababab",
    "bg_dim": "#232323",
    "hilight": "#1a4460",
    "hilight_alt": "#603e1a",
    "hi_blue": "#005fff",
    "hi_green": "#609611",
    "dim": "#333222",
    "dim_red": "#641400",
    "dim_orange": "#4d3715",
}
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
keys = [
    # quick-switch between groups
    Key([mod], "o", lazy.screen.toggle_group(), desc="desktop quick toggle"),
    Key([mod], "n", lazy.screen.next_group(), desc="next desktop"),
    Key([mod, "shift"], "n", lazy.screen.prev_group(), desc="prev desktop"),
    # traversing the stack
    Key([mod], "k", lazy.layout.up(), desc="focus up stack"),
    Key([mod], "j", lazy.layout.down(), desc="focus down stack"),
    Key([mod], "h", lazy.layout.left(), desc="focus left"),
    Key([mod], "l", lazy.layout.right(), desc="focus right"),
    # rearrange the stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move upward"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move downward"),
    Key([mod, "shift"], "h", lazy.layout.swap_left(), desc="Move pane left"),
    Key([mod, "shift"], "l", lazy.layout.swap_right(), desc="Move pane right"),
    # manipulate layout
    Key([mod, "shift"], "space", lazy.prev_layout(), desc="previous layout"),
    Key([mod], "space", lazy.next_layout(), desc="next layout"),
    Key([mod], "BackSpace", lazy.layout.normalize(), desc="reset layout"),
    Key([mod], "m", lazy.layout.maximize(), desc="mazimize"),
    Key([mod], "Tab", lazy.layout.flip(), desc="flip master and stack"),
    # resizing
    Key([mod, "control"], "h", lazy.layout.shrink(), desc="shrink window"),
    Key([mod, "control"], "l", lazy.layout.grow(), desc="grow window"),
    # window actions
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="toggle fullscreen"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    # programs
    Key([mod], "Return", lazy.spawn(terminal), desc="Alacritty terminal"),
    Key([mod], "d", lazy.spawn(script("~/.scripts/launchers/run-menu.sh")),
        desc="dmenu_run launcher"),
    Key([mod], "p", lazy.spawn("firefox -private"), desc="firefox -private"),
    Key([mod, "shift"], "p", lazy.spawn("brave-browser --incognito"),
        desc="brave-browser incognito"),
    Key([mod], "w", lazy.spawn("firefox"), desc="firefox"),
    Key([mod, "shift"], "w", lazy.spawn("brave-browser"),
        desc="brave-browser"),
    Key([mod], "F10",
        lazy.spawn(script("~/.scripts/launchers/keepassxc.themed.sh")),
        desc="keepassxc"),
    Key([mod], "F5",
        lazy.spawn(script("~/.scripts/commands/VPN.sh")),
        desc="nordvpn"),
    # hardware
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn(script("~/.scripts/system/volume-control.sh", "up")),
        desc="increase volume"),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn(script("~/.scripts/system/volume-control.sh", "down")),
        desc="decrease volume"),
    Key([], "XF86AudioMute",
        lazy.spawn(script("~/.scripts/system/volume-control.sh", "mute")),
        desc="mute volume"),
    Key([], "XF86MonBrightnessUp",
        lazy.spawn(script("~/.scripts/commands/macbook-backlight.sh", "up")),
        desc="screen backlight up"),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn(script("~/.scripts/commands/macbook-backlight.sh", "down")),
        desc="screen backlight down"),
    Key([], "XF86KbdBrightnessUp",
        lazy.spawn(
            script("~/.scripts/commands/macbook-keyboard-led.sh", "up")),
        desc="keyboard backlight up"),
    Key([], "XF86KbdBrightnessDown",
        lazy.spawn(
            script("~/.scripts/commands/macbook-keyboard-led.sh", "down")),
        desc="keyboard backlight down"),
    # mr. manager
    Key([mod], "F3", lazy.spawn(script("~/.scripts/commands/screenshot.sh")),
        desc="take a screenshot and autosave output"),
    Key([mod], "F8", lazy.spawn("alacritty -t htop -e htop"), desc="htop"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod, "control"], "s",
        lazy.spawn(script("~/.scripts/qtile/toggle-bar.py")),
        desc="toggle status bar visibility"),
    Key([mod, "control"], "w",
        lazy.spawn(script("~/.scripts/system/set-wallpaper.sh", "choose")),
        desc="change wallpaper"),
    Key([mod, "control"], "Return",
        lazy.spawn(script("~/.scripts/dmenu/change-terminal-xcolors.sh")),
        desc="change terminal colors and fonts"),
    Key([mod, "control"], "c",
        lazy.spawn(script("~/.scripts/launchers/compositor.sh")),
        desc="change compositor profile"),
    Key([mod], "F12",
        lazy.spawn(script("~/.scripts/launchers/i3lock.sh")),
        desc="lock desktop"),
    Key([mod, "control"], "v",
        lazy.spawn(script("~/.scripts/launchers/clipboard-manager.sh")),
        desc="toggle clipboard manager"),
    Key([mod, "control"], "n",
        lazy.spawn(script("~/.scripts/launchers/nightmode.sh", "toggle")),
        desc="toggle nightmode colors"),
    Key([mod], "Escape",
        lazy.spawn(script("~/.scripts/launchers/keystrokes.sh", "toggle")),
        desc="toggle screenkey"),
    # selectors
    Key([mod], "F1", lazy.spawn(script("~/.scripts/launchers/news.sh")),
        desc="open a news source"),
    Key([mod], "c", lazy.spawn(script("~/.scripts/launchers/chat-apps.sh")),
        desc="launch a chat app"),
    Key([mod, "control"], "y",
        lazy.spawn(script("~/.scripts/launchers/youtube-playlists.sh")),
        desc="youtube playlists"),
    Key([mod, "control"], "g",
        lazy.spawn(script("~/.scripts/launchers/google-services.sh")),
        desc="google services"),
    Key([mod, "control"], "m",
        lazy.spawn(script("~/.scripts/launchers/media-launcher.sh")),
        desc="media launcher"),
    Key([mod], "v",
        lazy.spawn(
            script("~/.scripts/launchers/clipboard-manager.sh", "choose")),
        desc="choose clipboard"),
]
#   __ _ _ __ ___  _   _ _ __  ___
#  / _` | '__/ _ \| | | | '_ \/ __|
# | (_| | | | (_) | |_| | |_) \__ \
#  \__, |_|  \___/ \__,_| .__/|___/
#  |___/                |_| desktops / workspaces
default_layouts = [
    layout.MonadTall(**{
        "border_focus": clr["hilight"],
        "border_width": my["border_width"],
        "margin": my["margin"],
    }),
    layout.MonadWide(**{
        "border_focus": clr["hilight"],
        "border_width": my["border_width"],
        "margin": my["margin"],
    }),
    layout.Max(),
]
my_groups = [
    {"name": "1", "label": "1", "layouts": default_layouts},
    {"name": "2", "label": "2", "layouts": default_layouts},
    {"name": "3", "label": "3", "layouts": default_layouts},
    {"name": "4", "label": "4", "layouts": default_layouts},
    {
        "name": "5", "label": "5",
        "layouts": default_layouts + [layout.Matrix()],
        "layout": "matrix",
    },
    {"name": "6", "label": "6", "layouts": default_layouts},
    {"name": "7", "label": "7", "layouts": default_layouts},
    {"name": "8", "label": "8", "layouts": default_layouts},
    {
        "name": "9", "label": "9",
        "matches": [
            Match(wm_class=['TelegramDesktop', 'Slack']),
            Match(title=["Mikey's Passwords - KeePassXC"]),
        ],
        "layout": "matrix",
        "layouts": default_layouts + [layout.Matrix()]
    },
    {"name": "0", "label": "!?!", "layouts": default_layouts},
]

groups = [Group(**g) for g in my_groups]
for i in groups:
    keys.extend([
        # mod + group_key = switch screen to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.label)),
        # mod + shift + group_key = move current window to group
        Key([mod, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=False),
            desc="Switch window to group {}".format(i.label)),
    ])

#     __                  ___                 _     __           __
#    / /_  ____ ______   ( _ )      _      __(_)___/ /___ ____  / /______
#   / __ \/ __ `/ ___/  / __ \/|   | | /| / / / __  / __ `/ _ \/ __/ ___/
#  / /_/ / /_/ / /     / /_/  <    | |/ |/ / / /_/ / /_/ /  __/ /_(__  )
# /_.___/\__,_/_/      \____/\/    |__/|__/_/\__,_/\__, /\___/\__/____/
# widgets and bar settings                        /____/
widget_defaults = dict(
    font=my["font"],
    fontsize=my["fontsize"],
    padding=3,
)
widget_cfg = {
    "GroupBox": {
        "active": clr["foreground"],
        "inactive": "#404040",
        "highlight_method": "block",
        "block_highlight_text_color": clr["foreground"],
        "urgent_alert_method": "border",
        "urgent_border": clr["urgent"],
        "hide_unused": True,
        "fontshadow": None,
    },
    "TaskList": {
        "background": clr["background"],
        "max_title_width": 400,
        "title_width_method": "uniform",
        "highlight_method": "block",
        "padding": 10,
        "icon_size": int(my["bar_height"] * 0.65),
        "margin_y": 0,
        "margin_x": 8,
    },
    "Pomodoro": {
        "prefix_inactive": "🍅",
        "prefix_paused": "⛔",
        "prefix_break": "🌴relax🌴",
        "background": clr["bg_dim"],
        "color_inactive": clr["fg_dim"],
        "padding": 10,
    },
    "CurrentLayout": {
        "padding": 10,
        "foreground": clr["fg_dim"],
        "background": clr["dim_red"],
    },
    "Battery": {
        "charge_char": "⚡",
        "discharge_char": "🔋",
        "full_char": "⛽",
        "update_interval": 5,
        "format": "{percent:2.0%}{char}{hour:d}:{min:02d}",
        "padding": 10,
        "background": clr["hilight"],
        "low_foreground": clr["urgent"],
        "low_percentage": 0.2,
        "show_short_text": False,
    },
    "Clock": {
        "format": "%Y-%m-%d %a %H:%M",
        "background": clr["bg_dim"],
        "padding": 10,
    },
    "Sep": {
        "linewidth": 2,
        "padding": 15,
        "size_percent": 65,
    },
    "WindowName": {
        "foreground": clr["fg_dim"],
        "background": clr["bg_dim"],
        "padding": 10,
    },
    "CurrentLayoutIcon": {},
    "Prompt": {},
    "Systray": {
        "background": clr["bg_dim"],
    },
    # this one doesn't seem to be working
    "Volume": {
        "background": clr["background"],
        "emoji": True,
        # "get_volume_command": script("~/.scripts/system/get-vol.sh"),
    },
    "Chord": {
        "chords_colors": {
            "launch": ("#ff0000", "#ffffff"),
        },
        "name_transform": lambda name: name.upper(),
    },
}

my_bar = [
    widget.GroupBox(**widget_cfg["GroupBox"]),
    widget.Sep(**widget_cfg["Sep"]),
    widget.Prompt(**widget_cfg["Prompt"]),
    widget.TaskList(**widget_cfg["TaskList"]),
    widget.CurrentLayoutIcon(**widget_cfg["CurrentLayoutIcon"]),
    # widget.CurrentLayout(**widget_cfg['CurrentLayout']),
    widget.Battery(**widget_cfg["Battery"]),
    # widget.Volume(**widget_cfg['Volume']),
    # widget.Backlight(),
    widget.Pomodoro(**widget_cfg["Pomodoro"]),
    widget.Systray(**widget_cfg["Systray"]),
    widget.Clock(**widget_cfg["Clock"]),
    # widget.Chord(**widget_cfg['Chord']),
    # widget.WindowName(**widget_cfg['WindowName']),
]

screens = [
    Screen(top=bar.Bar(my_bar, my["bar_height"])),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
floating_layout = layout.Floating(
    float_rules=[
        # Run `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)

# set to 'LG3D' by default for Java UI toolkit reasons. Changing to true WM
# name until something breaks
wmname = "qtile"
#              _            _             _
#   __ _ _   _| |_ ___  ___| |_ __ _ _ __| |_
#  / _` | | | | __/ _ \/ __| __/ _` | '__| __|
# | (_| | |_| | || (_) \__ \ || (_| | |  | |_
#  \__,_|\__,_|\__\___/|___/\__\__,_|_|   \__|


def batch_run(programs):
    for p in programs:
        if len(p) == 1:
            subprocess.run(os.path.expanduser(p[0]))
        elif len(p) == 2:
            subprocess.call([os.path.expanduser(p[0]), p[1]])


@hook.subscribe.startup_once
def enter_the_qtile():
    programs = [
        # ["~/.scripts/system/set-wallpaper.sh"],
        ["~/.scripts/launchers/notification-manager.sh"],
        ["~/.scripts/launchers/audio-tray.sh"],
        ["~/.scripts/launchers/network-manager-tray.sh"],
        ["~/.scripts/launchers/clipboard-manager.sh", "on"],
        ["~/.scripts/launchers/nightmode.sh", "on"],
        ["~/.scripts/launchers/compositor.sh", "on"],
        ["dropbox", "start"],
    ]
    batch_run(programs)


@hook.subscribe.startup
def restart_qtile():
    programs = [
        ["~/.scripts/system/set-wallpaper.sh"],
        # ["~/.scripts/launchers/audio-tray.sh"],
        # ["~/.scripts/launchers/network-manager-tray.sh"],
        # ["~/.scripts/launchers/clipboard-manager.sh", "on"],
    ]
    batch_run(programs)


# TODO -- list of issues to fix/address with config
# set WM_CLASS on bar so I can target it with my compositor (picom)
# low priority -- add unfocused_foreground unfocused_background to tasklist.py
#                             _       _     _
#   ___ ___  _ __  _   _ _ __(_) __ _| |__ | |_
#  / __/ _ \| '_ \| | | | '__| |/ _` | '_ \| __|
# | (_| (_) | |_) | |_| | |  | | (_| | | | | |_
#  \___\___/| .__/ \__, |_|  |_|\__, |_| |_|\__|
#           |_|    |___/        |___/
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
# Copyright (c) 2020 Mikey Garcia
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
