local awful = require("awful")
local naughty = require("naughty")

return function()
	local widget = nil
	local noti_obj = nil

	local cmd_get = "brillo -G"
	local cmd_inc = "brillo -A 5"
	local cmd_dec = "brillo -U 5"

	local get_level = function(cb)
		awful.spawn.easy_async(cmd_get, function(out)
			local level = string.match(out, "%d+")
			cb(level)
		end)
	end

	local action = function(cmd)
		awful.spawn.easy_async(cmd, function()
			get_level(function(level)
				local percentage = level .. "%"

				if widget then
					widget:emit_signal("brightness::update", level)
				end

				noti_obj = naughty.notify({
					replaces_id = noti_obj ~= nil and noti_obj.id or nil,
					text = percentage,
				})
			end)
		end)
	end

	return {
    get_level = get_level,
		increase = function()
			action(cmd_inc)
		end,
		decrease = function()
			action(cmd_dec)
		end,
		set_widget = function(w)
			widget = w
		end,
	}
end