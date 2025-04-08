return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, _)
          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end)
          vim.keymap.set("n", "<leader>d", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
          end)
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
