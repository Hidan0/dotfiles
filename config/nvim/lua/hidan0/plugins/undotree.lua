return {
  "mbbill/undotree",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, opts)
  end,
}
