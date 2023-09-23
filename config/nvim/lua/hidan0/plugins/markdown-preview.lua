return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = "cd app && yarn install",
  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
  end,
}
