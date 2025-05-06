return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, _)
          local keymap = vim.keymap
          local opts = { noremap = true, silent = true }

          keymap.set("n", "gD", function()
            vim.lsp.buf.declaration()
          end, opts) -- got to declaration
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
          keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- go to references
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
          keymap.set("n", "<leader>wS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, opts)
          keymap.set("n", "<leader>d", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
          end, opts)
        end,
        default_settings = {
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
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
      },
    }
  end,
}
