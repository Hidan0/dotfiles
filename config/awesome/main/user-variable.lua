local home = os.getenv("HOME")

local _M = {
  home = home,
  terminal = "alacritty",
  file_manager = "thunar",
  editor = os.getenv("EDITOR") or "vim",

  -- Default modkey
  modkey = "Mod4",

  -- wallpaper
  wallpaper = home .. "/Pictures/Wallpapers/evening-sky.png"
}

return _M
