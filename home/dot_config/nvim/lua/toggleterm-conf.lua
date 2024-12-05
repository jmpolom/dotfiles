MiniDeps.add({
    name = "toggleterm",
    source = "akinsho/toggleterm.nvim",
    checkout = "main",
})

require("toggleterm").setup({
    open_mapping = [[<C-Space>]],
    direction = "float",
})
