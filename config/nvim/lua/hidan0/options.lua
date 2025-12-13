-- GENERAL OPTIONS
--
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = false

vim.opt.autoindent = true

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "88"

-- faster completion
vim.opt.updatetime = 300

-- split window
vim.opt.splitright = true
vim.opt.splitbelow = true

-- backups and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.fileencoding = "utf-8"

-- spelling
vim.opt.spelllang = "en,it,cjk"
vim.opt.spellsuggest = "best,9"
vim.opt.spell = true

-- External editor options
vim.opt.exrc = true
