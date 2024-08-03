-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Appearance
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true

-- General
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.confirm = true
vim.opt.hidden = true
vim.opt.wildignore = vim.opt.wildignore + { "*/.git/*", "*/.DS_Store" }

-- Formatting
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Autocomplete
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Undo
vim.opt.undofile = true
vim.opt.undolevels = 5000

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tolerability
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Diagnostics
local function dx_format(d)
    return string.format("(%d:%d) %s", d.lnum, d.col, d.message)
end

vim.diagnostic.config({
    virtual_text = true,
    float = {
        format=dx_format,
    },
})
