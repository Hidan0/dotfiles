local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local ICONS = {
	unfocus = "",
	empty = "",
	focus = "",
}

-- Function to update the tags
local update_tags = function(self, c3)
	local tagicon = self:get_children_by_id("icon_role")[1]
	if c3.selected then
		tagicon.text = ICONS.focus
		self.fg = beautiful.main
	elseif #c3:clients() == 0 then
		tagicon.text = ICONS.empty
		self.fg = beautiful.bar_text
	else
		tagicon.text = ICONS.unfocus
		self.fg = beautiful.bar_text
	end
end

return function(s)
	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({}, 4, function(t)
			awful.tag.viewnext(t.screen)
		end),
		awful.button({}, 5, function(t)
			awful.tag.viewprev(t.screen)
		end)
	)

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = { shape = gears.shape.circle },
		layout = {
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.spacing,
		},
		widget_template = {
			{
				{
					id = "icon_role",
					font = "JetBrainsMono Nerd Font Mono 22",
					widget = wibox.widget.textbox,
				},
				id = "margin_role",
				top = dpi(0),
				bottom = dpi(0),
				left = dpi(1),
				right = dpi(1),
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, c3, _, _)
				update_tags(self, c3)
			end,
			update_callback = function(self, c3, _, _)
				update_tags(self, c3)
			end,
		},
		buttons = taglist_buttons,
	})

	return taglist
end
