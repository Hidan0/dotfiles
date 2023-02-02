local beautiful = require("beautiful")
local wibox = require("wibox")

local ICONS = { beautiful.tf_autobot_logo, beautiful.tf_decepticon_logo }

return function()
	return wibox.widget({
		{
			image = ICONS[math.random(#ICONS)],
			resize = true,
			widget = wibox.widget.imagebox,
		},
		left = beautiful.spacing_sm,
		right = beautiful.spacing_sm,
		top = beautiful.spacing_sm,
		bottom = beautiful.spacing_sm,
		widget = wibox.container.margin,
	})
end
