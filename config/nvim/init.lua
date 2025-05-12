require("hidan0.core")
require("hidan0.lazy")
require("hidan0.lsp")

vim.cmd("colorscheme catppuccin")

local UserGroup = vim.api.nvim_create_augroup("Hidan0", {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = UserGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
}) -- remove trailing whitespace

vim.api.nvim_create_autocmd("LspAttach", {
  group = UserGroup,
  callback = function(e)
    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true, buffer = e.buf }

    keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, opts) -- got to declaration
    keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts) -- see available code actions
    keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, opts) -- smart rename
    keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts) -- jump to previous diagnostic in buffer
    keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts) -- jump to next diagnostic in buffer
    keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts) -- show documentation for what is under cursor
    keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
  end,
})
