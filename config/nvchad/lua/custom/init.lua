local opt = vim.opt

opt.wrap = false

opt.scrolloff = 8

opt.clipboard = "unnamed"

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true

opt.fileencoding = "utf-8"

opt.updatetime = 300
