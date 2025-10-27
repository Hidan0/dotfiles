-- GENERAL KEYMAPS
--
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>ef", ":source %<CR>", { desc = "Source current file", silent = true })

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No highlight", silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffers
vim.keymap.set("n", "<leader>bl", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<leader>bh", ":bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>bk", ":bd<CR>", { desc = "Unload buffer", silent = true })
vim.keymap.set("n", "<leader>bK", ":bd!<CR>", { desc = "Force unload buffer", silent = true })

-- Window
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wq", ":close<CR>", { desc = "Close current window", silent = true })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make split window equal size" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })

-- cut, delete & paste
vim.keymap.set("n", "x", '"_x') -- doesn't copy single char
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste and delete into void
