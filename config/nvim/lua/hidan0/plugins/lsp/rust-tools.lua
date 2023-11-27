return {
  "simrat39/rust-tools.nvim",
  dependencies = "neovim/nvim-lspconfig",
  ft = "rust",
  config = function()
    local opts = {
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
      server = {
        on_attach = require("hidan0.utils.lsp").on_attach,
        capabilities = require("hidan0.utils.lsp").capabilities,
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
            },
            cargo = {
              loadOutDirsFromCheck = true,
              allFeatures = true,
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
    }

    require("rust-tools").setup(opts)
  end,
}
