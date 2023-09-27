return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "simrat39/rust-tools.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- import lsp-inlayhints
    local inlay_hints = require("lsp-inlayhints")
    -- import rust-tools
    local rust_tools = require("rust-tools")

    local border = require("hidan0.utils.borders")

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
      keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
      end, opts) -- jump to previous diagnostic in buffer
      keymap.set("n", "]d", function()
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

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- To set borders globally
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, ...)
      opts = opts or {}
      opts.border = opts.border or border("FloatBorder")
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- --------------------
    -- ---CONFIGURATIONS---
    -- --------------------

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure typescript server with plugin
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure rust-tools
    rust_tools.setup({
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
              command = "clippy",
            },
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      cmd = { require("mason-core.path").bin_prefix("rust-analyzer") },
      dap = {
        adapter = {
          type = "executable",
          command = "lldb-vscode",
          name = "rt_lldb",
        },
      },
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- configure volar
    lspconfig["volar"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure bash
    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
