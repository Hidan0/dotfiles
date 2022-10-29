local palette = require("themes.catppuccin.mocha")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

theme.font = "Hack Nerd Font 15"

theme.useless_gap = dpi(8)

theme.border_width = 0
theme.border_normal = palette.color['crust']
theme.border_focus = palette.color['surface2']
theme.border_marked = palette.color['yellow']

theme.menu_height = 30
theme.menu_width = 200

theme.menu_bg_normal = palette.color['base']
theme.menu_bg_focus = palette.color['mantle']
theme.menu_fg_focus = palette.color['red']
