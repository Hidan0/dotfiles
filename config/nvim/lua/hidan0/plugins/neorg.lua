return {
    {
        "nvim-neorg/neorg",
        enabled = true,
        lazy = false, -- Disable lazy loading
        tag = "v9.3.0",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { dir = "~/Dev/my-neorg-agenda" },
        },
        config = function()
            require("neorg").setup({
                -- Load and configure modules
                load = {
                    ["core.defaults"] = {}, -- Load default modules
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond",
                        },
                    },
                    ["core.dirman"] = { -- Manages workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes/neorg/",
                            },
                            default_workspace = "notes",
                        },
                    },
                    ["core.summary"] = {
                        config = {
                            strategy = "by_path",
                        },
                    },
                    ["external.my-neorg-agenda"] = {},
                },
            })

            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end,
    },
}
