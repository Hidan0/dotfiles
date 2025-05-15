return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        alpha = true,
        gitsigns = {
          enabled = true,
          transparent = false,
        },
        nvimtree = true,
        treesitter = true,
        harpoon = true,
        dap = true,
        dap_ui = true,
        rainbow_delimiters = true,
        telescope = true,
        indent_blankline = {
          enabled = false,
          scope_color = "mauve",
          colored_indent_levels = false,
        },
        blink_cmp = true,
        snacks = {
          enabled = true,
          indent_scope_color = "mauve",
        },
      },
    })
  end,
}
