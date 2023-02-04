local naughty = require("naughty")

local _M = {}

function _M.notify_string(object, timeout)
	if type(object) == "table" then
		local result = "{"
		for k, v in pairs(object) do
			result = result .. k .. "=" .. tostring(v) .. ",\n"
		end
		result = result:sub(1, -3) .. "}"
		naughty.notify({ title = "DEBUG STRING", text = result, timeout = timeout or 0 })
	else
		naughty.notify({ title = "DEBUG STRING", text = "" .. object, timeout = timeout or 0 })
	end
end

return _M
