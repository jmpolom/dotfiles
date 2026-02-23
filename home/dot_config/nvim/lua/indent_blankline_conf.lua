MiniDeps.add({
    name = "indent-blankline.nvim",
    source = "lukas-reineke/indent-blankline.nvim",
    checkout = "master",
})

require("ibl").setup()
