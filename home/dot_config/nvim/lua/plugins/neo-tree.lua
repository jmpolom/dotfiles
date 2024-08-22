return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_gitignored = false,
                    hide_dotfiles = false,
                },
            },
        },
        keys = {
            { "-", "<cmd>:Neotree toggle<CR>" },
            { "_", "<cmd>:Neotree toggle reveal<CR>" },
        },
    }
}
