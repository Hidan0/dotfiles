-- GENERAL KEYMAPS
--
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>ef", ":source %<CR>")

vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffers
vim.keymap.set("n", "<leader>bl", ":bnext<CR>")
vim.keymap.set("n", "<leader>bh", ":bprev<CR>")
vim.keymap.set("n", "<leader>bk", ":bd<CR>") -- unload buffer
vim.keymap.set("n", "<leader>bK", ":bd!<CR>") -- force unload buffer

-- Window
vim.keymap.set("n", "<leader>wv", "<C-w>v") -- split vertically
vim.keymap.set("n", "<leader>ws", "<C-w>s") -- split horizontally
vim.keymap.set("n", "<leader>wq", ":close<CR>") -- close current window
vim.keymap.set("n", "<leader>we", "<C-w>=") -- make split windows equal size
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wh", "<C-w>h")

-- cut, delete & paste
vim.keymap.set("n", "x", '"_x') -- doesn't copy single char
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste and delete into void
