-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")

require("decorations.wallpaper")

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function r_rect(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

local function mkcontainer(template)
  return wibox.widget {
    template,
    left = beautiful.spacing,
    right = beautiful.spacing,
    top = beautiful.spacing,
    bottom = beautiful.spacing,
    widget = wibox.container.margin,
  }
end

local function wrap_bg(template)
  return wibox.widget {
    {
      template, left = beautiful.spacing_sm,
      right = beautiful.spacing_sm,
      top = beautiful.spacing_sm,
      bottom = beautiful.spacing_sm,
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    shape = r_rect(20),
    bg = beautiful.bg_normal,
  }
end

-- {{{ Wibar
-- Create a textclock widget
clock = wibox.widget.textclock()

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a taglist widget
  s.mytaglist =
  awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    style           = { shape = gears.shape.circle, },
    layout          = {
      layout = wibox.layout.fixed.horizontal,
      spacing = beautiful.spacing,
    },
    widget_template = {
      {
        {
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal
        },
        left = beautiful.spacing_sm,
        right = beautiful.spacing_sm,
        widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
    },
    buttons         = taglist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = beautiful.bar_height,
    bg = theme.transparent,
    type = "dock"
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      wrap_bg(s.mytaglist),
    },
    clock,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
    },
  }
end)
-- }}}
