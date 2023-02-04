local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local awful = require("awful")
local gears = require("gears")

local ICONS = {
	normal = {
		[0] = "",
		[1] = "",
		[2] = "",
		[3] = "",
		[4] = "",
		[5] = "",
		[6] = "",
	},
}

local current_level = 20

local get_icon = function(level)
	level = tonumber(level)
	if level >= 90 then
		return ICONS.normal[6]
	elseif level >= 75 and level < 90 then
		return ICONS.normal[5]
	elseif level >= 60 and level < 75 then
		return ICONS.normal[4]
	elseif level >= 45 and level < 60 then
		return ICONS.normal[3]
	elseif level >= 30 and level < 45 then
		return ICONS.normal[2]
	elseif level >= 15 and level < 30 then
		return ICONS.normal[1]
	else
		return ICONS.normal[0]
	end
end

local set_icon = function(percentage, icon, level)
	percentage.markup = utils.colorize_markup(utils.percentage_to_cool_dots(level), beautiful.widget_brightness_fg)
	icon.markup = utils.colorize_markup(get_icon(level), beautiful.widget_brightness_fg)
end

return function()
	local icon = wibox.widget({
		markup = get_icon(current_level),
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

	local control_buttons =
		gears.table.join(awful.button({}, 4, utils.brightness.increase), awful.button({}, 5, utils.brightness.decrease))

	local widget = wibox.widget({
		icon,
		percentage,
		fg = beautiful.widget_brightness_fg,
		spacing = beautiful.spacing_sm,
		layout = wibox.layout.fixed.horizontal,
		buttons = control_buttons,
	})

	widget:connect_signal("brightness::update", function(_, level)
		if current_level ~= level then
			set_icon(percentage_text, icon, level)
		end

		current_level = level
	end)

	utils.brightness.get_level(function(level)
		set_icon(percentage_text, icon, level)
	end)

	return widget
end
