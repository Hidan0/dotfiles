return {
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>wm", "<cmd>MaximizerToggle<CR>" },
    },
  },
  { "neovim/nvim-lspconfig" }, -- LSP default configurations
}
