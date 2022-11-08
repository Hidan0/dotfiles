--
-- Original script from github.com/hnbnh
--
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

local OPTS = {
	timeout = 10,
	bat_item = 1,
	notify = true,
	notification_level = {
		happy = 70,
		tired = 50,
		sad = 20,
	},
}

local ICONS = {
	normal = {
		[0] = "",
		[10] = "",
		[20] = "",
		[30] = "",
		[40] = "",
		[50] = "",
		[60] = "",
		[70] = "",
		[80] = "",
		[90] = "",
		[100] = "",
	},
}

local NOTI_TYPE = { NONE = nil, HAPPY = "happy", SAD = "sad", TIRED = "tired", CHARGING = "charging" }

return function()
	local state = {
		current_level = 0,
		current_color = "",
		notified = NOTI_TYPE.NONE,
	}

	local notify = function(type, text)
		local preset_type = type == NOTI_TYPE.CHARGING and "normal" or "critical"
		if OPTS.notify and state.notified ~= type then
			naughty.notify({
				preset = naughty.config.presets[preset_type],
				text = text,
			})
			state.notified = type
		end
	end

	local icon = wibox.widget({
		markup = "<span foreground='" .. beautiful.fg_normal .. "'>" .. ICONS.normal[state.current_level] .. "</span>",
		font = beautiful.font,
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
		spacing = beautiful.spacing,
		layout = wibox.layout.fixed.horizontal,
	})

	watch("acpi -i", OPTS.timeout, function(_, stdout)
		local status, charge_str, _ =
		string.match(stdout, "Battery " .. OPTS.bat_item .. ": ([%a%s]+), (%d?%d?%d)%%,?(.*)")

		--------------------------------------------------------
		local level = math.floor(tonumber(charge_str))
		local tens = math.floor(level / 10) * 10
		local color = beautiful.fg_normal

		if status == "Charging" then
			notify(NOTI_TYPE.CHARGING, "Charging...")
		elseif level <= OPTS.notification_level.sad then
			notify(NOTI_TYPE.SAD, "Battery is low!")
		elseif level <= OPTS.notification_level.tired then
			notify(NOTI_TYPE.TIRED, "Battery is getting low!")
		end

		percentage_text.text = level .. "%"
		percentage.fg = color

		if state.current_color ~= color or state.current_level ~= tens then
			icon.markup = "<span foreground='" .. color .. "'>" .. ICONS.normal[tens] .. "</span>"
		end

		state.current_level = tens
		state.current_color = color
	end)

	return widget
end
