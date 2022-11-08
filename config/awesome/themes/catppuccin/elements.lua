local palette = require("themes.catppuccin.mocha")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

theme.font = "JetBrainsMono Nerd Font Mono 15"

theme.main = palette.color['blue']

theme.spacing = dpi(8)
theme.spacing_sm = dpi(6)
theme.useless_gap = dpi(5)

theme.transparent = palette.color['text'] .. "33"

theme.bg_normal = palette.color['base']
theme.fg_normal = palette.color['text']

theme.border_width = 3
theme.border_normal = palette.color['mantle']
theme.border_focus = theme.main

theme.menu_height = 40
theme.menu_width = 220

theme.menu_bg_normal = palette.color['base']
theme.menu_bg_focus = palette.color['mantle']
theme.menu_fg_focus = theme.main
theme.menu_border_color = theme.main
theme.menu_border_width = 1
-- BAR
theme.bar_height = 46
theme.taglist_bg = theme.bg_normal
theme.taglist_bg_focus = theme.main
theme.taglist_bg_urgent = palette.color['red']
theme.taglist_bg_urgent = palette.bg_normal
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_fg_occupied = theme.main
