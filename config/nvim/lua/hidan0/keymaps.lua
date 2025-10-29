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
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yanking" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy into system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+y]], { desc = "Copy entire line into system clipboard" })
vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete section without yanking" })
