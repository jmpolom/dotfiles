MiniDeps.add({
    name = "lualine",
    source = "nvim-lualine/lualine.nvim",
    checkout = "master",
    depends = { "nvim-tree/nvim-web-devicons" },
})

require("lualine").setup({
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
    extensions = {
        "fugitive",
        "neo-tree",
    },
})
