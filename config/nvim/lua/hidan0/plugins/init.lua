return {
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },
}
