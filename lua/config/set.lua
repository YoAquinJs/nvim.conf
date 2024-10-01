vim.opt.guicursor = ""

-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- show white spaces
vim.opt.list = true
vim.opt.listchars = {
    -- space = "·",
    tab = "→ ",
    trail = "·",
    extends = ">",
    precedes = "<",
}

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- tmp files
-- vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- vim.opt.clipboard:append("unnamedplus")
