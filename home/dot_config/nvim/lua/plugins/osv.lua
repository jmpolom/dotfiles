return {
    {
        "jbyuki/one-small-step-for-vimkind",
        config = function()
            vim.keymap.set("n", "<F5>", "<cmd>lua require(\"osv\").launch({port = 8086})<CR>", { noremap = true })
        end,
        event = "VeryLazy",
    }
}
