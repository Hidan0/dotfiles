local awful = require("awful")
awful.util = require("awful.util")

theme_path = awful.util.getdir("config") .. "/themes/catppuccin/"

theme = {}

dofile(theme_path .. "elements.lua")

-- theme.wallpaper = theme_path .. "bridge.jpg"
theme.wallpaper = theme_path .. "jstreet.jpg"

return theme
