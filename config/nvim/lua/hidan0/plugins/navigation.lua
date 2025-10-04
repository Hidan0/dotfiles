return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
            })

            vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil", silent = true })
        end,
    },
}
