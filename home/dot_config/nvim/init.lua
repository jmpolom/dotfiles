-- Plugins and settings are in their own modules
require("plugins")
require("options")

-- Strip trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e" })

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
