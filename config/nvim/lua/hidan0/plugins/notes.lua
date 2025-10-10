local org_path = "~/notes/org/"
local gtd_path = org_path .. "gtd/"

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
            })
        end,
    },
    -- NEORG
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        -- version = "*", -- Pin Neorg to the latest stable release
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
            "nvim-telescope/telescope.nvim",
            "nvim-orgmode/telescope-orgmode.nvim",
            "nvim-orgmode/org-bullets.nvim",
            "Saghen/blink.cmp",
        },
        config = function()
            require("orgmode").setup({
                win_split_mode = "tabnew",
                -- win_split_mode = { "float", 0.9 }, -- BUGGED with snacs
                org_agenda_files = { gtd_path .. "*" },
                org_default_notes_file = gtd_path .. "next.org",

                org_todo_keywords = {
                    "TODO(t)",
                    "PROGRESS(p)",
                    "WAIT(w)",
                    "HOLD(h)",
                    "|",
                    "DONE(d)",
                    "CANCELLED(c)",
                },

                org_hide_emphasis_markers = true,

                org_log_done = "time",
                org_log_into_drawer = "LOGBOOK",

                org_agenda_custom_commands = {
                    g = {
                        description = "GTD Agenda",
                        types = {
                            {
                                type = "agenda",
                                org_agenda_overriding_header = "📅 Whole week overview",
                                org_agenda_start_on_weekday = 1,
                            },
                            {
                                type = "tags_todo",
                                match = '-TODO="CANCELLED"|-TODO="DONE"',
                                org_agenda_overriding_header = "📥 Items to Process",
                                org_agenda_files = { gtd_path .. "inbox.org" },
                            },
                            {
                                type = "tags_todo",
                                org_agenda_overriding_header = "⚡️ Next Actions",
                                match = '-TODO="CANCELLED"|-TODO="DONE"',
                                org_agenda_files = {
                                    gtd_path .. "next.org",
                                },
                            },
                            {
                                type = "tags_todo",
                                match = '-TODO="CANCELLED"|-TODO="DONE"',
                                org_agenda_overriding_header = "🎯 Projects",
                                org_agenda_files = {
                                    gtd_path .. "projects.org",
                                },
                            },
                            {
                                type = "tags_todo",
                                org_agenda_overriding_header = "👀 Someday...",
                                match = '-TODO="CANCELLED"|-TODO="DONE"',
                                org_agenda_files = {
                                    gtd_path .. "someday.org",
                                },
                            },
                        },
                    },
                },
                org_capture_templates = {
                    i = {
                        description = "inbox",
                        template = "* TODO %?\nEntered on: %U",
                        target = gtd_path .. "inbox.org",
                    },
                    w = {
                        description = "Weekly Review",
                        template = [[
* Weekly Review %<%Y-%m-%d>

** Achievements
- %?

** Challenges

** Goals for Next Week
]],
                        target = gtd_path .. "reviews.org",
                        datetree = true, -- Uses datetree for entry.
                    },
                },

                org_priority_highest = "A",
                org_priority_lowest = "D",
                org_priority_default = "C",

                org_startup_indented = true,

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

            require("telescope").setup()
            require("telescope").load_extension("orgmode")

            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "nc"

            vim.keymap.set("n", "<leader>r", require("telescope").extensions.orgmode.refile_heading)
            vim.keymap.set("n", "<leader>fh", require("telescope").extensions.orgmode.search_headings)
            vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
        end,
    },
    {
        "chipsenkbeil/org-roam.nvim",
        tag = "0.2.0",
        dependencies = {
            { "nvim-orgmode/orgmode", version = "^0.7.0" },
        },
        config = function()
            require("org-roam").setup({
                directory = org_path .. "zet/",

                bindings = {
                    prefix = "<localleader>n",
                },
            })
        end,
    },
}
