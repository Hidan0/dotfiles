pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
local menubar = require("menubar")

RC = {}
RC.vars = require("main.user-variable")

-- Error handling
require("main.error-handling")

-- Theme
require("main.theme")

require("main.apps")

local main = {
  layouts = require("main.layouts"),
  tags = require("main.tags"),
  menu = require("main.menu"),
  rules = require("main.rules"),
}
require("main.signals")

local binding = {
  globalbuttons = require("bindings.globalbuttons"),
  clientbuttons = require("bindings.clientbuttons"),
  globalkeys    = require("bindings.globalkeys"),
  bindtotags    = require("bindings.bindtotags"),
  clientkeys    = require("bindings.clientkeys")
}

-- Mouse and key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

awful.rules.rules = main.rules(binding.clientkeys(), binding.clientbuttons())

local decorations = {
  wallpaper = require("decorations.wallpaper")
}


RC.layouts = main.layouts()

RC.tags = main.tags()

-- {{{ Menu }}}
RC.mainmenu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = RC.mainmenu })
menubar.utils.terminal = RC.vars.terminal

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)
end)
