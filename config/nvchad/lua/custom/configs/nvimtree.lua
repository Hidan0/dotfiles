local options = {
  filters = {
    dotfiles = false,
    exclude = { "" },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  view = {
    side = "right",
  },
}

return options
