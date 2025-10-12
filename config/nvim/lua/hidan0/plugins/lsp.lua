-- Enable Inlay Hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(_)
        vim.lsp.inlay_hint.enable(true)

        vim.keymap.set("n", "<leader>ti", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle LSP inlay hints" })
    end,
})

return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                            arrayIndex = "Enable",
                            await = true,
                            paramName = "All",
                            paramType = true,
                            semicolon = "Disable",
                            setType = true,
                        },
                    },
                },
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = true,
                        check = {
                            command = "clippy",
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
            })

            -- Enable language servers
            vim.lsp.enable({
                "lua_ls",
                "rust_analyzer",
            })
        end,
    },
    {
        "vxpm/ferris.nvim",
        opts = {},
    },
}
