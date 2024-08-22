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
vim.opt.clipboard = { "unnamedplus" }
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
local dx_signs = {
    Error = "󰅚",
    Warn = "󰀪",
    Info = "",
    Hint = "󰌶",
}

local function dx_format(d)
    local float_signs = {dx_signs.Error, dx_signs.Warn, dx_signs.Info, dx_signs.Hint}
    return string.format("(%d:%d) %s %s", d.lnum, d.col, float_signs[d.severity], d.message)
end

vim.diagnostic.config({
    float = {
        border = "rounded",
        format = dx_format,
    },
    severity_sort = true,
    virtual_text = true,
})

if vim.version.ge(vim.version(), {0,10,0}) then
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = dx_signs.Error,
                [vim.diagnostic.severity.WARN] = dx_signs.Warn,
                [vim.diagnostic.severity.INFO] = dx_signs.Info,
                [vim.diagnostic.severity.HINT] = dx_signs.Hint,
            },
        },
    })
else
    for type, icon in pairs(dx_signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end
