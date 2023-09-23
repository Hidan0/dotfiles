return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = "yarn install && cd app && yarn install", -- install dependencies
  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
  end,
}
