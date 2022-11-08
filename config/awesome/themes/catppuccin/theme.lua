local awful = require("awful")
awful.util = require("awful.util")

theme_path = awful.util.getdir("config") .. "/themes/catppuccin/"

theme = {}

dofile(theme_path .. "elements.lua")

theme.wallpaper = theme_path .. "cyber.jpg"

return theme
