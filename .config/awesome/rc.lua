-- Mikey Garca, @gikeymarcia config for AwesomeWM v4.3
--                                             __        ____  __
--   __ ___      _____  ___  ___  _ __ ___   __\ \      / /  \/  |
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / /| |\/| |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V / | |  | |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/  |_|  |_|
--
-- {{{ Initalize awesome elements
-- plugin
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Modkeys -- Mod4 is Windows key
modkey = "Mod4"
alt = "Mod1"
shift = "Shift"
ctrl = "Control"
home_dir = os.getenv("HOME") .. '/' or "/home/mikey/"
terminal = os.getenv("TERMINAL") or "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Themes define colours, icons, font and wallpapers.
beautiful.init( home_dir .. ".config/awesome/default-theme.lua" )

-- }}}

-- {{{ Layouts, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.corner.ne,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.corner.sw,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.corner.se,
    -- awful.layout.suit.corner.nw,
}
-- }}}

-- {{{ Helper functions
local function highlight_focused_screen()
    awful.screen.connect_for_each_screen(function(s)
        if s == awful.screen.focused() then
            s.mywibox.opacity = .95
            s.mywibox.bg = beautiful.bg_focus_dark
        else
            s.mywibox.opacity = .5
            s.mywibox.bg = beautiful.bg_normal
        end
    end)
end

local function set_wallpaper(s)
    awful.spawn(home_dir .. ".scripts/system/set-wallpaper.sh" , false )
end

local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 350 } })
        end
    end
end

-- }}}

-- {{{ Statusbar Mouse Actions
-- {{{ Mouse Actions for taglist
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
-- }}}

-- {{{ Mouse Actions for tasklist (running apps)
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, client_menu_toggle_fn()),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end)
)
-- }}}
-- }}}

-- {{{ Create statusbars for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Define tag table
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Wallpaper
    set_wallpaper(s)

    -- {{{ create widgets
    -- taglist (desktops/tags)
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- tasklist (running apps)
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- promptbox
    s.mypromptbox = awful.widget.prompt()

    -- textclock
    mytextclock = wibox.widget.textclock()

    -- layout icon
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- }}}

    -- {{{ Create wibox (statusbar)
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        -- Middle widget
        s.mytasklist,
        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            require("battery-widget") {},
            mytextclock,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
    -- }}}
end)
--- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function ()
        awful.spawn(home_dir .. ".scripts/launchers/run-menu.sh", false)
    end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
-- {{{ globalkeys
globalkeys = gears.table.join(
-- HELPERS
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

-- TRAVERSING TAGS
    awful.key({ modkey,           }, "n",  awful.tag.viewnext,
              {description = "next tag", group = "tag"}),
    awful.key({ modkey, shift   }, "n",   awful.tag.viewprev,
              {description = "previous tag", group = "tag"}),
    awful.key({ modkey,           }, "o", awful.tag.history.restore,
              {description = "last tag", group = "tag"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

-- Window Gaps
    awful.key({ modkey,           }, "g",  function() awful.tag.incgap(1) end,
              {description = "grow window gaps", group = "tag"}),
    awful.key({ modkey, shift     }, "g",  function() awful.tag.incgap(-1) end,
              {description = "shrink window gaps", group = "tag"}),

-- Changing focused client -- win + [ h, j, k, l ]
    awful.key({ modkey,           }, "h",
        function () awful.client.focus.global_bydirection("left") end,
        {description = "focus LEFT", group = "client"}),
    awful.key({ modkey,           }, "j",
        function () awful.client.focus.byidx(1) end,
        {description = "focus UP the stack", group = "client"}),
    awful.key({ modkey,           }, "k",
        function () awful.client.focus.byidx(-1) end,
        {description = "focus DOWN the stack", group = "client"}),
    awful.key({ modkey,           }, "l",
        function () awful.client.focus.global_bydirection("right") end,
        {description = "focus RIGHT", group = "client"}),


-- LAYOUT MANIPULATION
    -- cycle layouts
    awful.key({ modkey,           }, "space", function () awful.layout.inc(1)   end,
              {description = "next layout", group = "layout"}),
    awful.key({ modkey, shift   }, "space", function () awful.layout.inc(-1)  end,
              {description = "previous layout", group = "layout"}),

    -- reorder stack
    awful.key({ modkey, shift   }, "h", function () awful.client.swap.bydirection("left")  end,
              {description = "move up", group = "client"}),
    awful.key({ modkey, shift   }, "j", function () awful.client.swap.bydirection("down")  end,
              {description = "move down", group = "client"}),
    awful.key({ modkey, shift   }, "k", function () awful.client.swap.bydirection("up")  end,
              {description = "move up", group = "client"}),
    awful.key({ modkey, shift   }, "l", function () awful.client.swap.bydirection("right")  end,
              {description = "move up", group = "client"}),

    -- resize master
    awful.key({ modkey, ctrl   }, "h",     function () awful.tag.incmwfact(-0.02) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, ctrl   }, "l",     function () awful.tag.incmwfact(0.02) end,
              {description = "increase master width factor", group = "layout"}),
    -- control # of master columns
    awful.key({ modkey, ctrl   }, "k",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, ctrl   }, "j",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    -- changing screens -- win + i
    awful.key({ modkey            }, "i", function ()
                    awful.screen.focus_relative(1)
                    highlight_focused_screen()
                end, {description = "focus other screen", group = "screen"}),
    -- swap screens -- win + tab (TODO)
    awful.key({ modkey }, "Tab", function () awful.spawn('rofi -show window') end,
        {description = "swap screens", group = "client"}),

-- LAUNCHERS
    -- run menu
    awful.key({ modkey }, "d",
        function () awful.spawn(home_dir .. ".scripts/launchers/run-menu.sh", false) end,
        {description = "dmenu_run", group = "launcher"}),
    -- terminal
    awful.key({ modkey,           }, "Return",
        function () awful.spawn("alacritty") end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey            }, "F1",
        function () awful.spawn(home_dir .. ".scripts/launchers/documentation-selector.sh", false) end,
        {description = "Choose documentation site", group = "launcher"}),
    awful.key({ modkey, shift   }, "F1",
        function () awful.spawn(home_dir .. ".scripts/launchers/note-selector.sh", false) end,
        {description = "View my notes", group = "launcher"}),
    awful.key({ modkey            }, "F2",
        function () awful.spawn(home_dir .. ".scripts/launchers/news.sh", false) end,
        {description = "Choose new source", group = "launcher"}),
    awful.key({ modkey            }, "F3",
        function () awful.spawn(home_dir .. ".scripts/commands/screenshot.sh", false) end,
        {description = "Choose watson project", group = "launcher"}),
    awful.key({ modkey            }, "F4",
        function () awful.spawn(home_dir .. ".scripts/launchers/watson.py", false) end,
        {description = "Choose watson project", group = "launcher"}),
    awful.key({ modkey            }, "F5",
        function () awful.spawn(home_dir .. ".scripts/commands/VPN.sh", false) end,
        {description = "VPN quick selector", group = "launcher"}),
    awful.key({ modkey            }, "F8",
        function () awful.spawn("alacritty -t htop -e htop", false) end,
        {description = "VPN quick selector", group = "launcher"}),
    awful.key({ modkey, shift }, "Return",
        function () awful.spawn(home_dir .. ".scripts/dmenu/term-font.sh", false) end,
        {description = "change  terminal font", group = "launcher"}),
    awful.key({ modkey, ctrl }, "Return",
        function () awful.spawn(home_dir .. ".scripts/dmenu/term-colorscheme.sh", false) end,
        {description = "change  terminal colorscheme", group = "launcher"}),
    awful.key({ modkey, }, "F10",
        function () awful.spawn(home_dir .. ".scripts/launchers/keepassxc.themed.sh", false) end,
        {description = "keepass", group = "launcher"}),

    -- web browsers
    -- brave
    awful.key({ modkey }, "p",
        function () awful.spawn("brave-browser --incognito") end,
        {description = "brave (incognito mode)", group = "launcher"}),
    awful.key({ modkey }, "w", function () awful.spawn("brave-browser") end,
        {description = "brave", group = "launcher"}),
    -- firefox
    awful.key({ modkey , shift }, "p",
        function () awful.spawn("firefox -private") end,
        {description = "firefox (incognito)", group = "launcher"}),
    awful.key({ modkey, shift  }, "w",
        function () awful.spawn("firefox") end,
        {description = "firefox", group = "launcher"}),

    -- file manager
    awful.key({ modkey }, "e", function () awful.spawn("thunar") end,
        {description = "thunar file manager", group = "launcher"}),

    -- selectors
    awful.key({ modkey },            "c",
        function () awful.spawn(home_dir .. ".scripts/launchers/chat-apps.sh", false) end,
        {description = "chat app selector", group = "launcher"}),
    awful.key({ modkey, ctrl},  "y",
        function () awful.spawn(home_dir .. ".scripts/launchers/youtube-playlists.sh", false) end,
        {description = "youtube playlists", group = "launcher"}),
    awful.key({ modkey, ctrl},  "g",
        function () awful.spawn(home_dir .. ".scripts/launchers/google-services.sh", false) end,
        {description = "google services", group = "launcher"}),
    awful.key({ modkey, ctrl},  "m",
        function () awful.spawn(home_dir .. ".scripts/launchers/media-launcher.sh", false) end,
        {description = "media launcher", group = "launcher"}),
    awful.key({ modkey  },  "v",
        function () awful.spawn(home_dir .. ".scripts/launchers/clipboard-manager.sh choose", false) end,
        {description = "choose clipboard entry", group = "launcher"}),


-- MR. MANAGER
    awful.key({ modkey, ctrl }, "r",   awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, ctrl   }, "q",   awesome.quit,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey , ctrl }, "c",
        function () awful.spawn(home_dir .. ".scripts/launchers/compositor.sh", false ) end,
        {description = "change compositor profile", group = "system"}),
    awful.key({ modkey}, "F12",
        function () awful.spawn(home_dir .. ".scripts/launchers/i3lock.sh", false ) end,
        {description = "lock screen", group = "system"}),
    awful.key({ modkey , ctrl }, "v",
        function () awful.spawn(home_dir .. ".scripts/launchers/clipboard-manager.sh", false ) end,
        {description = "toggle clipboard manager", group = "system"}),
    awful.key({ modkey , ctrl }, "n",
        function () awful.spawn(home_dir .. ".scripts/launchers/nightmode.sh toggle", false ) end,
        {description = "toggle nightmode colors", group = "system"}),
    awful.key({ modkey , shift, ctrl }, "w",
        function () awful.spawn(home_dir .. ".scripts/system/set-wallpaper.sh stop", false ) end,
        {description = "change wallpaper", group = "system"}),
    awful.key({ modkey , ctrl }, "w",
        function () awful.spawn(home_dir .. ".scripts/system/set-wallpaper.sh choose", false ) end,
        {description = "change wallpaper", group = "system"}),
-- HARDWARE
    awful.key({ }, "XF86AudioRaiseVolume",
        function () awful.spawn(home_dir .. ".scripts/system/volume-control.sh up", false ) end,
        {description = "raise volume", group = "hardware"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function () awful.spawn(home_dir .. ".scripts/system/volume-control.sh down", false ) end,
        {description = "lower volume", group = "hardware"}),
    awful.key({ }, "XF86AudioMute",
        function () awful.spawn(home_dir .. ".scripts/system/volume-control.sh mute", false ) end,
        {description = "mute audio", group = "hardware"}),
    awful.key({ }, "XF86AudioPlay",
        function () awful.spawn("playerctl play-pause", false ) end,
        {description = "play/pause media toggle", group = "hardware"}),
    awful.key({ }, "XF86MonBrightnessUp",
        function () awful.spawn(home_dir .. ".scripts/commands/backlight.sh up", false ) end,
        {description = "screen backlight up", group = "hardware"}),
    awful.key({ }, "XF86MonBrightnessDown",
        function () awful.spawn(home_dir .. ".scripts/commands/backlight.sh down", false ) end,
        {description = "screen backlight down", group = "hardware"}),
    awful.key({ }, "XF86KbdBrightnessUp",
        function () awful.spawn(home_dir .. ".scripts/commands/macbook-keyboard-led.sh up", false ) end,
        {description = "keyboard backlight up", group = "hardware"}),
    awful.key({ }, "XF86KbdBrightnessDown",
        function () awful.spawn(home_dir .. ".scripts/commands/macbook-keyboard-led.sh down", false ) end,
        {description = "keyboard backlight down", group = "hardware"}),


-- DISABLED
awful.key({ modkey, shift }, "s",
    function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            client.focus = c
            c:raise()
        end
    end,
    {description = "show minimized client", group = "client"})
)
-- }}}

-- {{{ clientkeys
clientkeys = gears.table.join(
-- move client position
    awful.key({ modkey, shift }, "Return",
        function (c) c:swap(awful.client.getmaster()) end,
        {description = "move client to master position", group = "layout"}),
    awful.key({ modkey, shift  }, "i", function (c) c:move_to_screen() end,
         {description = "move client to next screen", group = "client"}),
-- change client properties
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "toggle client maximize", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle client fullscreen", group = "client"}),
    awful.key({ modkey, ctrl  }, "s",
        function (c) c.sticky = not c.sticky end ,
        {description = "make client sticky across tags", group = "client"}),
-- minimize
    awful.key({ modkey, shift   }, "m",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
      {description = "minimize", group = "client"}),
-- close
    awful.key({ modkey, shift   }, "c",      function (c) c:kill()    end,
              {description = "close", group = "client"}),
-- float toggle
    awful.key({ modkey, shift }, "f",  awful.client.floating.toggle,
              {description = "toggle floating", group = "layout"})
)

-- UNUSED
    -- awful.key({ modkey, ctrl  }, "t",
    --     function (c) c.ontop = not c.ontop  end,
    --     {description = "toggle keep on top", group = "client"}),
-- }}}

-- {{{ Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, ctrl }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, shift }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle all screens to tag
        awful.key({ modkey , alt}, "#" .. i + 9,
                  awful.screen.connect_for_each_screen(function (s)
                      local tag = s.tags[i]
                      if tag then
                          tag:view_only()
                      end
                  end),
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctrl, shift }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
-- }}}

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ RULES applied to new clients (through the "manage" signal).
awful.rules.rules = {
    -- {{{ All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },
    -- }}}
    -- {{{ force non-floating
    {
        rule_any = {
            instance = { },
            class = { },
            name = { "Generate Password" },
            role = { },
        }, properties = { floating = false }
    },
    -- }}}

    -- {{{ Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
            },
            class = {
              "Arandr",
              "Gpick",
              "Kruler",
              "MessageWin",  -- kalarm.
              -- "Sxiv",
              "Wpa_gui",
              "pinentry",
              "veromix",
              "xtightvncviewer"
            },
            name = {
              "Event Tester",  -- xev.
            },
            role = {
              "AlarmWindow",  -- Thunderbird's calendar.
              -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, properties = { floating = true }
    },
    -- }}}
}
-- }}}

-- {{{ Signals (execute actions on change)

-- client is focued
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    highlight_focused_screen()
end)

-- client is unfocued
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
    highlight_focused_screen()
end)

-- set wallpaper when sreen size changes
screen.connect_signal("property::geometry", set_wallpaper)

-- a new client (window) appears
client.connect_signal("manage", function (c)
    -- Prevent clients from being unreachable after screen count changes.
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
    -- open windows @ end of stack
    -- if not awesome.startup then
    --     awful.client.setslave(c)
    -- end
end)

-- focus follows mouse (sloppy focus)
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
    highlight_focused_screen()
end)

-- }}}

-- {{{ STARTUP applications
do
local cmds =
  {
    -- environment values
    "xrdb -merge " .. home_dir .. ".Xresources",
    "xmodmap " ..     home_dir .. ".Xmodmap",
    "numlockx on",
    -- system UI components
    home_dir .. ".scripts/launchers/compositor.sh on",
    home_dir .. ".scripts/launchers/network-manager-tray.sh",
    home_dir .. ".scripts/launchers/audio-tray.sh",
    home_dir .. ".scripts/launchers/clipboard-manager.sh on",
    home_dir .. ".scripts/launchers/nightmode.sh",
    -- home_dir .. ".dropbox-dist/dropboxd"
  }

  for _,i in pairs(cmds) do
    awful.spawn(i, false)
  end
end
-- }}}

-- {{{ Disabled Stuff
-- local menubar = require("menubar")
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ titlebars

-- Add titlebars to normal clients and dialogs
-- { rule_any = {type = { "normal", "dialog" }
--   }, properties = { titlebars_enabled = false }
-- },

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
--     -- buttons for the titlebar
--     local buttons = gears.table.join(
--         awful.button({ }, 1, function()
--             client.focus = c
--             c:raise()
--             awful.mouse.client.move(c)
--         end),
--         awful.button({ }, 3, function()
--             client.focus = c
--             c:raise()
--             awful.mouse.client.resize(c)
--         end)
--     )

--     awful.titlebar(c) : setup {
--         { -- Left
--             awful.titlebar.widget.iconwidget(c),
--             buttons = buttons,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         { -- Middle
--             { -- Title
--                 align  = "center",
--                 widget = awful.titlebar.widget.titlewidget(c)
--             },
--             buttons = buttons,
--             layout  = wibox.layout.flex.horizontal
--         },
--         { -- Right
--             awful.titlebar.widget.floatingbutton (c),
--             awful.titlebar.widget.maximizedbutton(c),
--             awful.titlebar.widget.stickybutton   (c),
--             awful.titlebar.widget.ontopbutton    (c),
--             awful.titlebar.widget.closebutton    (c),
--             layout = wibox.layout.fixed.horizontal()
--         },
--         layout = wibox.layout.align.horizontal
--     }
-- end)
-- }}}

-- {{{ RULES
-- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
-- }}}

-- {{{ Client keys
--  awful.key({ modkey, ctrl }, "m",
--      function (c)
--          c.maximized_vertical = not c.maximized_vertical
--          c:raise()
--      end ,
--      {description = "(un)maximize vertically", group = "client"}),
--  awful.key({ modkey, shift   }, "m",
--      function (c)
--          c.maximized_horizontal = not c.maximized_horizontal
--          c:raise()
--      end ,
--      {description = "(un)maximize horizontally", group = "client"})
-- }}}
-- }}}

-- vim: foldmethod=marker:foldlevel=0
