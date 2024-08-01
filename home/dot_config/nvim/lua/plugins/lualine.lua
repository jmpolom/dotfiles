return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                section_separators = "",
                component_separators = "",
                disabled_filetypes = {
                    statusline = {
                        "neo-tree",
                    },
                    winbar = {
                        "neo-tree"
                    }
                },
                ignore_focus = { "neo-tree" },
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    }
                },
            },
            extensions = { "fugitive", "neo-tree" },
        },
    }
}
