return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        ft = { "markdown", "quarto" },
        ---@module 'render-markdown'
        config = function()
            require("render-markdown").setup({
                render_modes = true,
                completions = { lsp = { enabled = true } },
                latex = {
                    enabled = false, -- SNACS
                },
            })
        end,
    },
    -- NEORG
    {
        "nvim-neorg/neorg",
        enabled = false,
        lazy = false,
        commit = "4da2159",
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes/neorg/",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            })

            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end,
    },
    -- ORG
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            "nvim-orgmode/org-bullets.nvim",
            "Saghen/blink.cmp",
        },
        config = function()
            require("orgmode").setup({
                ui = {
                    folds = {
                        colored = true,
                    },
                    input = {
                        use_vim_ui = true,
                    },
                },
            })

            require("org-bullets").setup()

            require("blink.cmp").setup({
                sources = {
                    per_filetype = {
                        org = { "orgmode" },
                    },
                    providers = {
                        orgmode = {
                            name = "Orgmode",
                            module = "orgmode.org.autocompletion.blink",
                            fallbacks = { "buffer" },
                        },
                    },
                },
            })
            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "nc"
        end,
    },
}
