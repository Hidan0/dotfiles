-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local utils = require("utils")

local wibox = require("wibox")

require("decorations.wallpaper")

local widgets = {
	battery = require("decorations.battery"),
	volume = require("decorations.volume"),
	brightness = require("decorations.brightness"),
	cpu = require("decorations.cpu"),
	cpu_temp = require("decorations.temperature"),
	my_taglist = require("decorations.taglist"),
	random_icon = require("decorations.random_icon"),
}

local function r_rect(radius)
	return function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, radius)
	end
end

local function mkcontainer(template)
	return wibox.widget({
		{
			{
				template,
				left = beautiful.spacing_mm,
				right = beautiful.spacing_mm,
				widget = wibox.container.margin,
			},
			shape = r_rect(20),
			bg = beautiful.taglist_wrapper_bg,
			fg = beautiful.main,
			widget = wibox.container.background,
		},
		top = beautiful.spacing_sm,
		bottom = beautiful.spacing_sm,
		widget = wibox.container.margin,
	})
end

-- {{{ Wibar
-- Create a textclock widget
local date = wibox.widget.textclock("%a %b %d, %H:%M")

local volume = widgets.volume()
utils.volume.set_widget(volume)

local brightness = widgets.brightness()
utils.brightness.set_widget(brightness)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Create a taglist widget
	s.mytaglist = widgets.my_taglist(s)

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = beautiful.bar_height,
		bg = beautiful.bar_bg,
		type = "dock",
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		{
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				widgets.random_icon(),
				s.mytaglist,
			},
			nil,
			{ -- Right widgets
				spacing = beautiful.spacing_sm,
				mkcontainer(widgets.cpu()),
				mkcontainer(widgets.cpu_temp()),
				mkcontainer(widgets.battery()),
				mkcontainer(brightness),
				mkcontainer(volume),
				mkcontainer(wibox.widget.systray()),
				mkcontainer(date),
				layout = wibox.layout.fixed.horizontal,
			},
		},
		left = beautiful.useless_gap * 2,
		right = beautiful.useless_gap * 2,
		widget = wibox.container.margin,
	})
end)
-- }}}
