--
-- Original script from github.com/hnbnh
--
local wibox = require("wibox")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local utils = require("utils")

local OPTS = {
	timeout = 10,
	bat_item = 1,
}

local ICONS = {
	normal = {
		[0] = "",
		[25] = "",
		[50] = "",
		[75] = "",
		[100] = "",
	},
}

return function()
	local state = {
		current_level = 0,
		current_color = beautiful.widget_battery_fg_full,
	}

	local icon = wibox.widget({
		markup = utils.colorize_markup(ICONS.normal[state.current_level], state.current_color),
		font = beautiful.font_ls,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local percentage_text = wibox.widget({
		id = "percent_text",
		text = state.current_level .. "%",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local percentage = wibox.container.background(percentage_text)

	local widget = wibox.widget({
		icon,
		percentage,
		spacing = beautiful.spacing_sm,
		layout = wibox.layout.fixed.horizontal,
	})

	watch("acpi -i", OPTS.timeout, function(_, stdout)
		local status, charge_str, _ =
			string.match(stdout, "Battery " .. OPTS.bat_item .. ": ([%a%s]+), (%d?%d?%d)%%,?(.*)")

		--------------------------------------------------------
		local level = math.floor(tonumber(charge_str))
		local quarters = math.floor(level / 25) * 25
		local color

		if status == "Full" then
			color = beautiful.widget_battery_fg_full
		elseif level > 50 then
			color = beautiful.widget_battery_fg_half_full
		elseif level > 25 then
			color = beautiful.widget_battery_fg_half_empty
		else
			color = beautiful.widget_battery_fg_charger_needed
		end

		percentage_text.text = level .. "%"
		percentage.fg = color

		if state.current_color ~= color or state.current_level ~= quarters then
			icon.markup = utils.colorize_markup(ICONS.normal[quarters], color)
		end

		state.current_level = quarters
		state.current_color = color
	end)

	return widget
end
