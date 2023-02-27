local gears = require("gears")
local awful = require("awful")

local hotkeys_popup = require("awful.hotkeys_popup")

local modkey = RC.vars.modkey
local terminal = RC.vars.terminal
local file_manager = RC.vars.file_manager

local _M = {}

function _M.get()
	local globalkeys = gears.table.join(
		awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
		awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
		awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
		awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

		awful.key({ modkey }, "j", function()
			awful.client.focus.byidx(1)
		end, { description = "focus next by index", group = "client" }),
		awful.key({ modkey }, "k", function()
			awful.client.focus.byidx(-1)
		end, { description = "focus previous by index", group = "client" }),
		awful.key({ modkey }, "w", function()
			RC.mainmenu:show()
		end, { description = "show main menu", group = "awesome" }),

		-- Layout manipulation
		awful.key({ modkey, "Shift" }, "j", function()
			awful.client.swap.byidx(1)
		end, { description = "swap with next client by index", group = "client" }),
		awful.key({ modkey, "Shift" }, "k", function()
			awful.client.swap.byidx(-1)
		end, { description = "swap with previous client by index", group = "client" }),
		awful.key({ modkey, "Control" }, "j", function()
			awful.screen.focus_relative(1)
		end, { description = "focus the next screen", group = "screen" }),
		awful.key({ modkey, "Control" }, "k", function()
			awful.screen.focus_relative(-1)
		end, { description = "focus the previous screen", group = "screen" }),
		awful.key({ modkey }, "p", function()
			awful.spawn.with_shell("betterlockscreen --lock")
		end, { description = "lock screen", group = "screen" }),
		awful.key(
			{ modkey },
			"u",
			awful.client.urgent.jumpto,
			{ description = "jump to urgent client", group = "client" }
		),
		awful.key({ modkey }, "Tab", function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end, { description = "go back", group = "client" }),

		-- Standard program
		awful.key({ modkey }, "Return", function()
			awful.spawn(terminal)
		end, { description = "open the terminal", group = "launcher" }),
		awful.key({ modkey, "Shift" }, "Return", function()
			awful.spawn(file_manager)
		end, { description = "open the file manager", group = "launcher" }),
		awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
		awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

		awful.key({ modkey }, "l", function()
			awful.tag.incmwfact(0.05)
		end, { description = "increase master width factor", group = "layout" }),
		awful.key({ modkey }, "h", function()
			awful.tag.incmwfact(-0.05)
		end, { description = "decrease master width factor", group = "layout" }),
		awful.key({ modkey, "Shift" }, "h", function()
			awful.tag.incnmaster(1, nil, true)
		end, { description = "increase the number of master clients", group = "layout" }),
		awful.key({ modkey, "Shift" }, "l", function()
			awful.tag.incnmaster(-1, nil, true)
		end, { description = "decrease the number of master clients", group = "layout" }),
		awful.key({ modkey, "Control" }, "h", function()
			awful.tag.incncol(1, nil, true)
		end, { description = "increase the number of columns", group = "layout" }),
		awful.key({ modkey, "Control" }, "l", function()
			awful.tag.incncol(-1, nil, true)
		end, { description = "decrease the number of columns", group = "layout" }),
		awful.key({ modkey }, "space", function()
			awful.layout.inc(1)
		end, { description = "select next", group = "layout" }),
		awful.key({ modkey, "Shift" }, "space", function()
			awful.layout.inc(-1)
		end, { description = "select previous", group = "layout" }),

		awful.key({ modkey, "Control" }, "n", function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end, { description = "restore minimized", group = "client" }),

		-- Menus
		awful.key({ modkey, "Shift" }, "d", function()
			awful.spawn.with_shell("rofi -show drun")
		end, { description = "app launcher", group = "launcher" }),
		awful.key({ modkey }, "c", function()
			awful.spawn.with_shell("rofi -show calc -modi calc -no-show-match -no-sort")
		end, { description = "launch calculator", group = "launcher" }),
		awful.key({ modkey }, "e", function()
			awful.spawn.with_shell("rofi -show emoji -modi emoji")
		end, { description = "launch emoji picker", group = "launcher" }),

		-- Controls
		awful.key({}, "Print", function()
			awful.spawn.with_shell("flameshot gui")
		end, { description = "take a screenshot", group = "controlls" }),
		awful.key({}, "XF86AudioRaiseVolume", function()
			RC.utils.volume.increase()
		end, { description = "raise volume", group = "audio" }),
		awful.key({}, "XF86AudioLowerVolume", function()
			RC.utils.volume.decrease()
		end, { description = "lower volume", group = "audio" }),
		awful.key({}, "XF86AudioMute", function()
			RC.utils.volume.toggle()
		end, { description = "mute volume", group = "audio" }),
		awful.key({}, "XF86AudioPlay", function()
			awful.spawn.with_shell("playerctl play-pause")
		end, { description = "play audio", group = "audio" }),
		awful.key({}, "XF86AudioNext", function()
			awful.spawn.with_shell("playerctl next")
		end, { description = "next audio", group = "audio" }),
		awful.key({}, "XF86AudioPrev", function()
			awful.spawn.with_shell("playerctl previous")
		end, { description = "previous audio", group = "audio" }),
		awful.key({}, "XF86AudioStop", function()
			awful.spawn.with_shell("playerctl stop")
		end, { description = "stop audio", group = "audio" }),

		awful.key({}, "XF86MonBrightnessUp", function()
			RC.utils.brightness.increase()
		end, { description = "increase brightness", group = "brightness" }),
		awful.key({}, "XF86MonBrightnessDown", function()
			RC.utils.brightness.decrease()
		end, { description = "decrease brightness", group = "brightness" })
	)
	return globalkeys
end

return setmetatable({}, {
	__call = function(_, ...)
		return _M.get(...)
	end,
})
