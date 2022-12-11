local wibox = require("wibox")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local utils = require("utils")

local OPTS = {
	cmd = "bash -c 'sensors | grep 'Package id 0:''",
	icon = "",
	color = beautiful.cpu_temp,
	timeout = 10,
}

return function()
	local icon = wibox.widget({
		markup = utils.colorize_markup(OPTS.icon, OPTS.color),
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local temp_text = wibox.widget({
		text = "ciao",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	watch(OPTS.cmd, OPTS.timeout, function(widget, stdout)
		local temp = stdout:match('+%d+'):sub(2)
		widget:set_markup_silently(utils.colorize_markup(temp .. "°C", OPTS.color))
	end, temp_text)

	local temperature = wibox.container.background(temp_text)
	temperature.fg = OPTS.color

	local cpu_temp_widget = wibox.widget({
		icon,
		temperature,
		spacing = beautiful.spacing_sm,
		layout = wibox.layout.fixed.horizontal,
	})

	return cpu_temp_widget
end
