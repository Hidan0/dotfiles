return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true, notify = true },
            dashboard = {
                enabled = true,
                preset = {
                    header = [[
       ⡰⠀⠀⠀⠀⠀⢀⠀⢀⣠⠂⠀⢀⠀⣠⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀ ⣀⣼⠃⢀⢠⣄⣾⣶⣿⣆⣾⣿⢂⣶⣿⣿⡃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀ ⢠⣶⡿⠃⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢁⣴⣤⣾⣤⣶⠞⠁⠀
⠀ ⣬⣾⡿⠁⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡥⠀⠀⠀
 ⣠⣿⣿⠃⠀⢸⣿⡟⣿⠟⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀
⢠⣾⣿⡟⠀⠀⠀⠿⠁⠿⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣷⣖⣀⣀
⠘⣿⣿⡇⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⠁
⢺⣿⣿⣇⠀⠀⠀⠀⠀⠀⡠⢾⣿⠟⠉⠉⢸⣿⣿⣿⣿⣿⣿⣿⣿⣏⡉⠀⠀⠀
⢨⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠁⠃⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡆⠀⠀
⠘⢿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠙⠋⠉⠁⠀
⠀⠺⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡅⠀⠀⠀⠀
⠀⠀⠠⣿⣿⣿⣿⣿⣿⣶⣦⣤⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⡅⠈⠈⠀⠀⠀⠀
⠀⠀⠀⠈⠩⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠻⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠻⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠙⠉⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
                },
            },
            explorer = { enabled = false },
            image = { enabled = false },
            indent = { enabled = true },
            input = {
                enabled = true,
                icon = " ",
                icon_hl = "SnacksInputIcon",
                icon_pos = "left",
                prompt_pos = "title",
                win = { style = "input" },
                expand = true,
            },
            lazygit = { enabled = false },
            notifier = { enabled = true, timeout = 3000 },
            notify = { enabled = true },
            picker = {
                enabled = true,
                sources = {
                    files = {
                        layout = "ivy",
                    },
                },
            },
            profiler = { enabled = false },
            quickfile = { enabled = true },
            rename = { enabled = true },
            scope = { enabled = false },
            scratch = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            terminal = { enabled = false },
            words = { enabled = false },
            zen = { enabled = false },
        },
        keys = {
            -- File pickers
            {
                "<leader>ff",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fs",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep files",
            },
            {
                "<leader>fc",
                function()
                    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "Find config files",
            },
            {
                "<leader>fp",
                function()
                    Snacks.picker.projects()
                end,
                desc = "Find projects",
            },
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Find buffers",
            },
            -- git
            {
                "<leader>gb",
                function()
                    Snacks.picker.git_branches()
                end,
                desc = "Git Branches",
            },
            {
                "<leader>gl",
                function()
                    Snacks.picker.git_log()
                end,
                desc = "Git Log",
            },
            {
                "<leader>gL",
                function()
                    Snacks.picker.git_log_line()
                end,
                desc = "Git Log Line",
            },
            {
                "<leader>gs",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git Status",
            },
            {
                "<leader>gS",
                function()
                    Snacks.picker.git_stash()
                end,
                desc = "Git Stash",
            },
            {
                "<leader>gd",
                function()
                    Snacks.picker.git_diff()
                end,
                desc = "Git Diff (Hunks)",
            },
            {
                "<leader>gf",
                function()
                    Snacks.picker.git_log_file()
                end,
                desc = "Git Log File",
            },
            -- Grep
            {
                "<leader>sb",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Buffer Lines",
            },
            {
                "<leader>sB",
                function()
                    Snacks.picker.grep_buffers()
                end,
                desc = "Grep Open Buffers",
            },
            {
                "<leader>sg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>sw",
                function()
                    Snacks.picker.grep_word()
                end,
                desc = "Visual selection or word",
                mode = { "n", "x" },
            },
            -- Search
            {
                "<leader>sd",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>sD",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "Buffer Diagnostics",
            },
            {
                "<leader>sh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>sm",
                function()
                    Snacks.picker.marks()
                end,
                desc = "Marks",
            },
            {
                "<leader>sM",
                function()
                    Snacks.picker.man()
                end,
                desc = "Man Pages",
            },
            {
                "<leader>su",
                function()
                    Snacks.picker.undo()
                end,
                desc = "Undo History",
            },
            -- LSP
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Goto Definition",
            },
            {
                "gD",
                function()
                    Snacks.picker.lsp_declarations()
                end,
                desc = "Goto Declaration",
            },
            {
                "gr",
                function()
                    Snacks.picker.lsp_references()
                end,
                nowait = true,
                desc = "References",
            },
            {
                "gI",
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "Goto Implementation",
            },
            {
                "gy",
                function()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = "Goto T[y]pe Definition",
            },
            {
                "<leader>ss",
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "LSP Symbols",
            },
            {
                "<leader>sS",
                function()
                    Snacks.picker.lsp_workspace_symbols()
                end,
                desc = "LSP Workspace Symbols",
            },
            -- OTHER
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>gB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
                mode = { "n", "v" },
            },
            {
                "<leader>un",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Dismiss All Notifications",
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end

                    -- Override print to use snacks for `:=` command
                    if vim.fn.has("nvim-0.11") == 1 then
                        vim._print = function(_, ...)
                            dd(...)
                        end
                    else
                        vim.print = _G.dd
                    end
                end,
            })
        end,
    },
}
