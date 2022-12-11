local wibox = require("wibox")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local utils = require("utils")

local OPTS = {
	cmd = "cat /proc/stat | grep '^cpu '",
	icon = "",
	color = beautiful.cpu_usage,
	timeout = 2,
}

return function()
	local state = {
		idle_prev = 0,
		total_prev = 0,
	}

	local icon = wibox.widget({
		markup = utils.colorize_markup(OPTS.icon, OPTS.color),
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local percentage_text = wibox.widget({
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	watch(OPTS.cmd, OPTS.timeout, function(widget, stdout)
		local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
		stdout:match('(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)')

		local total = user + nice + system + idle + iowait + irq + softirq + steal

		local diff_idle = idle - tonumber(state.idle_prev)
		local diff_total = total - tonumber(state.total_prev)
		local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

		state.total_prev = total
		state.idle_prev = idle
		widget:set_markup_silently(utils.colorize_markup(math.floor(diff_usage) .. "%", OPTS.color))
	end, percentage_text)

	local percentage = wibox.container.background(percentage_text)
	percentage.fg = OPTS.color

	local cpu_widget = wibox.widget({
		icon,
		percentage,
		spacing = beautiful.spacing_sm,
		layout = wibox.layout.fixed.horizontal,
	})

	return cpu_widget
end
