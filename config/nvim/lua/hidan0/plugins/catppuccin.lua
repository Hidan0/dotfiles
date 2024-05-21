return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        harpoon = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        rainbow_delimiters = true,
        telescope = true,
        indent_blankline = {
          enabled = true,
          scope_color = "mauve",
          colored_indent_levels = false,
        },
      },
    })
  end,
}
