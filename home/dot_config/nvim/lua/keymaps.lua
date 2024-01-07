-- Space deactivated in normal+visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- No more macros
vim.keymap.set("n", "q", "<Nop>")

-- Double escape turns off search highlighting
vim.keymap.set("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR><C-l><CR>",
  { silent = true })

-- Buffer nav
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("n", "<C-q>", ":bprevious <BAR> bd #<CR>")
-- vim.keymap.set("n", "<C-v>", ":vsplit<CR>")
-- vim.keymap.set("n", "<C-q>", ":close<CR>")
-- vim.keymap.set("n", "<S-l>", ":wincmd l<CR>")
-- vim.keymap.set("n", "<S-h>", ":wincmd h<CR>")

-- Pasting indent
vim.keymap.set("n", "p", "[p")
vim.keymap.set("n", "P", "[P")

-- Diagnostics
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
