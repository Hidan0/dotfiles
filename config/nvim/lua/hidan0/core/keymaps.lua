vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

------------
-- General
------------
keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear highlight after search

keymap.set("n", "<leader>+", "<C-a>") -- increment number
keymap.set("n", "<leader>-", "<C-x>") -- decrement number

-- Window management
keymap.set("n", "<leader>wv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>ws", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>wq", ":close<CR>") -- close current window
keymap.set("n", "<leader>we", "<C-w>=") -- make split windows equal size

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts) --  go to previous tab
keymap.set("n", "<S-h>", ":bprevious<CR>", opts) --  go to previous tab
keymap.set("n", "<leader>x", ":bd<CR>", opts) -- unload buffer
keymap.set("n", "<leader>X", ":bd!<CR>", opts) -- force unload buffer

-- Move text in visual
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z") -- append line without moving cursor
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- cut, delete & paste
keymap.set("n", "x", '"_x') -- doesn't copy single char
keymap.set("x", "<leader>p", [["_dP]]) -- paste and delete into void
keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- cpy into sys clipboard
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set("v", "<leader>d", [["_d]])

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tms<CR>")
------------
-- Plugins
------------
-- nvim-tmux-navigator for window navigation
keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", opts)
keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", opts)
keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", opts)
keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", opts)
