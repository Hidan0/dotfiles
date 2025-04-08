local M = {}
-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- import lsp-inlayhints
local inlay_hints = require("inlay-hints")

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
  keymap.set("n", "gD", function()
    vim.lsp.buf.declaration()
  end, opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
  keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- go to references
  keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts) -- see available code actions
  keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, opts) -- smart rename
  keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float()
  end, opts) -- show diagnostics for cursor
  keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
  end, opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
  end, opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts) -- show documentation for what is under cursor
  keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, opts)
  keymap.set("n", "<leader>wS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

  inlay_hints.on_attach(client, bufnr)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

M.on_attach = on_attach
M.capabilities = capabilities

return M
