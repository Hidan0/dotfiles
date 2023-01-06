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

-- Window navigation
-- keymap.set("n", "<leader>wh", "<C-w>h")
-- keymap.set("n", "<leader>wj", "<C-w>j")
-- keymap.set("n", "<leader>wk", "<C-w>k")
-- keymap.set("n", "<leader>wl", "<C-w>l")

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts) --  go to previous tab
keymap.set("n", "<S-h>", ":bprevious<CR>", opts) --  go to previous tab

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

------------
-- Plugins
------------

-- vim-maximizer
keymap.set("n", "<leader>wm", ":MaximizerToggle<CR>", opts) -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

-- nvim-tmux-navigator for window navigation
keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", opts)
keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", opts)
keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", opts)
keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", opts)
