local sb_path = "/home/hidan0/notes/second_brain/"
local function check_for_notes_wsp()
    local current = vim.fn.expand("%:p")

    local sub = current:match(sb_path)
    return sub ~= nil
end

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        ft = { "markdown", "quarto" },
        ---@module 'render-markdown'
        config = function()
            require("render-markdown").setup({
                render_modes = true,
                latex = {
                    enabled = false, -- SNACS
                },
                indent = {
                    enabled = true,
                },
            })
        end,
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            default = {
                use_absolute_path = false,
                relative_to_current_file = function()
                    return not check_for_notes_wsp()
                end,

                -- `<file_name>-img` as dir
                dir_path = function()
                    if check_for_notes_wsp() then
                        return sb_path .. "assets/imgs/"
                    else
                        return vim.fn.expand("%:t:r") .. "-imgs"
                    end
                end,

                prompt_for_file_name = false,
                file_name = "%Y%m%d_%H%M%S",
            },
            filetypes = {
                markdown = {
                    url_encode_path = true,
                    template = function()
                        if check_for_notes_wsp() then
                            return "![[$FILE_NAME]]"
                        else
                            return "![$CURSOR](./$FILE_PATH)"
                        end
                    end,
                },
            },
        },
        keys = {
            { "<leader>nip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
    },
}
