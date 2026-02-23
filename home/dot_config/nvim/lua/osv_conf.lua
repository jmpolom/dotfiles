MiniDeps.add({
    name = "osv",
    source = "jbyuki/one-small-step-for-vimkind",
    checkout = "main",
})

vim.keymap.set("n", "<F5>", "<cmd>lua require(\"osv\").launch({port = 8086})<CR>", { noremap = true })
