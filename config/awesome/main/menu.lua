local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- local beautiful = require("beautiful")

local M = {} -- menu
local _M = {} -- module

local terminal = RC.vars.terminal

local editor = os.getenv("EDITOR") or "vim"
local editor_cmd = terminal .. " -e " .. editor

M.awesome = {
  { " Hotkeys", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
  end },
  { " Edit Config", editor_cmd .. " " .. awesome.conffile },
  { "勒 Reload Config", awesome.restart },
  { " Terminal", terminal },
}

M.powermenu = {
  { "⏻ PowerOff", function() awful.util.spawn("systemctl poweroff") end },
  { " Restart", function() awful.util.spawn("systemctl reboot") end },
  { "⏾ Suspend", function() awful.util.spawn("systemctl suspend") end },
  { " Log out", function() awesome.quit() end },
}

function _M.get()
  local menu_items = {
    { " Awesome", M.awesome },
    { "⏻ Powermenu", M.powermenu }
  }

  return menu_items
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
