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
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            local Snacks = require("snacks")

            vim.keymap.set("n", "<leader>ha", function()
                harpoon:list():add()
            end, { desc = "Add to harpoon" })
            vim.keymap.set("n", "<leader>hr", function()
                harpoon:list():remove()
            end, { desc = "Remove from harpoon" })

            vim.keymap.set("n", "<leader>he", function()
                Snacks.picker({
                    finder = function()
                        local output = {}
                        for _, item in ipairs(harpoon:list().items) do
                            if item and item.value:match("%S") then
                                table.insert(output, {
                                    text = item.value,
                                    file = item.value,
                                    pos = { item.context.row, item.context.col },
                                })
                            end
                        end
                        return output
                    end,
                    format = function(item)
                        return {
                            { item.text },
                            { ":", "SnacksPickerDelim" },
                            { tostring(item.pos[1]), "SnacksPickerRow" },
                            { ":", "SnacksPickerDelim" },
                            { tostring(item.pos[2]), "SnacksPickerCol" },
                        }
                    end,
                    preview = function(ctx)
                        if Snacks.picker.util.path(ctx.item) then
                            return Snacks.picker.preview.file(ctx)
                        else
                            return Snacks.picker.preview.none(ctx)
                        end
                    end,
                    confirm = "jump",
                })
            end, { desc = "Open harpoon navigation menu" })

            vim.keymap.set("n", "<leader>hh", function()
                harpoon:list():prev()
            end, { desc = "Previous harpoon item" })
            vim.keymap.set("n", "<leader>hl", function()
                harpoon:list():prev()
            end, { desc = "Previous harpoon item" })
        end,
    },
}
