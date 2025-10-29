-- GENERAL KEYMAPS
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No highlight", silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffers
vim.keymap.set("n", "<leader>bl", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<leader>bh", ":bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>bk", ":bd<CR>", { desc = "Unload buffer", silent = true })
vim.keymap.set("n", "<leader>bK", ":bd!<CR>", { desc = "Force unload buffer", silent = true })

-- cut, delete & paste
vim.keymap.set("n", "x", '"_x') -- doesn't copy single char
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste and delete into void
