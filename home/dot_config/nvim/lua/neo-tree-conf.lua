MiniDeps.add({
    name = "neo-tree.nvim",
    source = "nvim-neo-tree/neo-tree.nvim",
    checkout = "v3.x",
    depends = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
})

require("neo-tree").setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = true,
            hide_gitignored = false,
            hide_dotfiles = false,
        },
    },
})

vim.keymap.set("n", "-", "<cmd>:Neotree toggle<CR>")
vim.keymap.set("n", "_", "<cmd>:Neotree toggle reveal<CR>")
