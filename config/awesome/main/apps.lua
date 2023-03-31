local awful = require("awful")

local apps = {
	"xfce4-power-manager",
	"blueberry-tray",
	"picom --experimental-backends --config " .. RC.vars.home .. "/.config/picom/picom.conf",
	"optimus-manager-qt",
	"flameshot",
	"/usr/lib/polkit-kde-authentication-agent-1",
}

for app = 1, #apps do
	awful.spawn.with_shell(apps[app])
end
