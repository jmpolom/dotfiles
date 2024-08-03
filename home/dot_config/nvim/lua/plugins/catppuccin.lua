return {
    { "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        init = function()
            vim.cmd("colorscheme catppuccin-macchiato")
        end,
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
        },
    }
}
