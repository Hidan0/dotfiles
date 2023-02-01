local palette = require("themes.catppuccin.mocha")

local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

theme.font = "JetBrainsMono Nerd Font Mono 15"

theme.main = palette.color["blue"]

theme.spacing = dpi(8)
theme.spacing_sm = dpi(6)
theme.useless_gap = dpi(3)

theme.transparent = "#00000000"

theme.bg_normal = palette.color["base"]
theme.fg_normal = palette.color["text"]

theme.border_width = 3
theme.border_normal = palette.color["mantle"]
theme.border_focus = theme.main

theme.menu_height = 40
theme.menu_width = 220

theme.menu_bg_normal = palette.color["base"]
theme.menu_bg_focus = palette.color["mantle"]
theme.menu_fg_focus = theme.main
theme.menu_border_color = theme.main
theme.menu_border_width = 1

--
-- BAR
--
theme.bar_text = palette.color["overlay1"]
theme.bar_height = 42
theme.taglist_bg = theme.bg_normal
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_bg_urgent = palette.color["red"]
theme.taglist_bg_urgent = palette.bg_normal
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_fg_occupied = theme.main

-- BRIGHTNESS widge
theme.widget_brightness_fg = palette.color["yellow"]

-- BATTERY widget
theme.widget_battery_fg_full = palette.color["teal"]
theme.widget_battery_fg_half_full = palette.color["green"]
theme.widget_battery_fg_half_empty = palette.color["peach"]
theme.widget_battery_fg_charger_needed = palette.color["red"]

-- CPU widget
theme.cpu_usage = palette.color["sky"]
theme.cpu_temp = palette.color["red"]
