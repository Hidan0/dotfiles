-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local utils = require("utils")

local wibox = require("wibox")

require("decorations.wallpaper")

local widgets = {
  battery = require("decorations.battery"),
  volume = require("decorations.volume"),
  brightness = require("decorations.brightness")
}

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
    left = beautiful.spacing_sm,
    right = beautiful.spacing_sm,
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
local clock = wibox.widget.textclock("%H:%M")
local date = wibox.widget.textclock("%a %b %d %Y")

local volume = widgets.volume()
utils.volume.set_widget(volume)

local brightness = widgets.brightness()
utils.brightness.set_widget(brightness)

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
    {
      layout = wibox.layout.stack,
      {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          wrap_bg(s.mytaglist),
        },
        nil,
        { -- Right widgets
          spacing = beautiful.spacing_sm,
          wrap_bg({
            mkcontainer(widgets.battery()),
            mkcontainer(brightness),
            mkcontainer(volume),
            layout = wibox.layout.fixed.horizontal,
          }),
          wrap_bg(wibox.widget.systray()),
          wrap_bg(mkcontainer(date)),
          layout = wibox.layout.fixed.horizontal,
        },
      },
      {
        wrap_bg(mkcontainer(clock)),
        valign = "center",
        halign = "center",
        layout = wibox.container.place
      },
    },
    left = beautiful.useless_gap * 2,
    top = beautiful.useless_gap * 2,
    right = beautiful.useless_gap * 2,
    widget = wibox.container.margin
  }
end)
-- }}}
