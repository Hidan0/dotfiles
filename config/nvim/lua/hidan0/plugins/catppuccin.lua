return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
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
      },
    })
    vim.cmd([[colorscheme catppuccin]])
  end,
}
