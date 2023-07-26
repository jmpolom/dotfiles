return {
    { "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        opts = {
            integrations = {
                illuminate = true,
                markdown = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                },
                neotree = true,
                treesitter = true,
            }
        }
    }
}
