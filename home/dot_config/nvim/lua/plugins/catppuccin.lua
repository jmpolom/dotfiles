return {
    { "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        opts = {
            integrations = {
                treesitter = true,
                mason = true,
                neotree = true,
                markdown = true,
                native_lsp = {
                    enabled = true,
                },
            }
        }
    }
}
