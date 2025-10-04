return {
    {
        "nvim-mini/mini.pairs",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "nvim-mini/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "nvim-mini/mini.comment",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        config = function()
            require("mini.comment").setup()
        end,
    },
    {
        "nvim-mini/mini.move",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        config = function()
            require("mini.move").setup()
        end,
    },
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    go = { "gofmt", "goimports" },
                    ocaml = { "ocamlformat" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    typst = { "prettypst" },
                },
                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>F", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },
}
