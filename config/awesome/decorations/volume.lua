local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local awful = require("awful")
local gears = require("gears")

local ICONS = {
	normal = {
		high = "墳",
		low = "奄",
		medium = "奔",
		mute = "婢",
	},
}

local current_level = 50
local current_status = "on"

local get_icon = function(level, status)
	level = tonumber(level)
	if status == "off" then
		return ICONS.normal.mute
	end

	if level >= 75 then
		return ICONS.normal.high
	elseif level >= 40 then
		return ICONS.normal.medium
	elseif level >= 10 then
		return ICONS.normal.low
	end
end

local set_icon = function(percentage, icon, level, status)
	if status == "on" then
		percentage.text = utils.percentage_to_cool_dots(level)
	else
		percentage.text = utils.percentage_to_cool_dots(0)
	end
	icon.markup = get_icon(level, status)
end

return function()
	local icon = wibox.widget({
		markup = get_icon(current_level),
		font = beautiful.font,
		forced_width = beautiful.spacing_lg,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local percentage_text = wibox.widget({
		id = "percent_text",
		font = beautiful.font_ms,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local percentage = wibox.container.background(percentage_text)

	local control_buttons = gears.table.join(
		awful.button({}, 1, utils.volume.toggle),
		awful.button({}, 3, function()
			awful.spawn("pavucontrol")
		end),
		awful.button({}, 4, utils.volume.increase),
		awful.button({}, 5, utils.volume.decrease)
	)

	local widget = wibox.widget({
		icon,
		percentage,
		spacing = beautiful.spacing,
		layout = wibox.layout.fixed.horizontal,
		buttons = control_buttons,
	})

	widget:connect_signal("volume::update", function(_, level, status)
		if current_level ~= level or current_status ~= status then
			set_icon(percentage_text, icon, level, status)
		end

		current_level = level
		current_status = status
	end)

	utils.volume.get_level(function(level, status)
		set_icon(percentage_text, icon, level, status)
	end)

	return widget
end
