local _M = {}

_M.colorize_markup = function(text, color)
  return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

_M.volume = require("utils.volume")()
_M.brightness = require("utils.brightness")()

return _M
