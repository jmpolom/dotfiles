local function open_float_all()
    vim.diagnostic.open_float(nil,{
        focus = false,
        scope = "buffer",
    })
end

-- Space deactivated in normal+visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- No more macros
vim.keymap.set("n", "q", "<Nop>")

-- Double escape turns off search highlighting
vim.keymap.set("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>",
  { silent = true })

-- Buffer Navigation
vim.keymap.set("n", "<C-I>", "<C-I>")
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("n", "<C-q>", ":bprevious <BAR> bd #<CR>")
vim.keymap.set("n", "<C-S-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-S-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-S-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-S-k>", ":wincmd k<CR>")

-- Diagnostics
vim.keymap.set("n", "dl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "da", open_float_all)
vim.keymap.set("n", "d[", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "d]", "<cmd>lua vim.diagnostic.goto_next()<cr>")
