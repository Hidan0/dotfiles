local _M = {}

_M.colorize_markup = function(text, color)
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

_M.volume = require("utils.volume")()
_M.brightness = require("utils.brightness")()

_M.percentage_to_cool_dots = function(percentage, len)
	local DOT_ICON = ""
	local EMPTY_ICON = ""
	local n_of_dots = math.floor(percentage / (len or 10))

	local repeat_str = function(str, times)
		local out = ""
		while times > 0 do
			out = out .. str
			times = times - 1
		end
		return out
	end

	return repeat_str(DOT_ICON, n_of_dots) .. repeat_str(EMPTY_ICON, (len or 10) - n_of_dots)
end

return _M
