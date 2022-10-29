local awful = require("awful")

local apps = {
  RC.vars.home .. "/.config/polybar/launch.sh",
  "xfce4-power-manager",
  "xfce4-screensaver",
  "blueberry-tray",
  "picom --experimental-backends --config " .. RC.vars.home .. "/.config/picom/picom.conf",
  "optimus-manager-qt",
  "flameshot",
  "nm-applet"
}

for app = 1, #apps do
  awful.spawn.with_shell(apps[app])
end
