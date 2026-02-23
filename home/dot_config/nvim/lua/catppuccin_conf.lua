MiniDeps.add({
    name = "catppuccin",
    source = "catppuccin/nvim",
    checkout = "v1.9.0",
})

require("catppuccin").setup({
    integrations = {
        cmp = true,
        illuminate = true,
        markdown = true,
        native_lsp = {
            enabled = true,
        },
        neotree = true,
        treesitter = true,
    }
})

vim.cmd("colorscheme catppuccin-macchiato")
