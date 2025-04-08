return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local border = require("hidan0.utils.borders")

    local on_attach = require("hidan0.utils.lsp").on_attach
    local capabilities = require("hidan0.utils.lsp").capabilities

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- To set borders globally
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
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
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
          hint = {
            enable = true,
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

    -- configure go
    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          },
        },
      },
    })

    -- configure marksman
    lspconfig["marksman"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure zig
    lspconfig["zls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        zls = {
          enable_inlay_hints = true,
          inlay_hints_show_builtin = true,
          inlay_hints_exclude_single_argument = true,
          inlay_hints_hide_redundant_param_names = false,
          inlay_hints_hide_redundant_param_names_last_token = false,
        },
      },
    })

    -- configure c/c++
    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
      settings = {
        clangd = {
          InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
          },
        },
      },
    })

    -- configure typst
    lspconfig["tinymist"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable",
      },
    })
  end,
}
