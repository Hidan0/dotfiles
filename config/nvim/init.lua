require("hidan0.keymaps")
require("hidan0.options")
require("hidan0.lazy")

-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

require("hidan0.terminal")
require("hidan0.notes")
