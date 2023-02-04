local beautiful = require("beautiful")
local wibox = require("wibox")

local timer = require("gears.timer")

local function source_icons()
	local icons = {}
	for file in io.popen("ls " .. beautiful.icon_dir):lines() do
		table.insert(icons, beautiful.icon_dir .. file)
	end
	return icons
end

return function()
	local ICONS = source_icons()
	local icon_index = math.random(#ICONS)

	local image = wibox.widget.imagebox(ICONS[icon_index])
	image.resize = true

	local change_icon = timer({ timeout = 1200 })

	change_icon:connect_signal("timeout", function()
		icon_index = math.random(#ICONS)
		image.image = ICONS[icon_index]
	end)

	change_icon:start()

	return wibox.widget({
		image,
		left = beautiful.spacing_sm,
		right = beautiful.spacing_sm,
		top = beautiful.spacing_sm,
		bottom = beautiful.spacing_sm,
		widget = wibox.container.margin,
	})
end
