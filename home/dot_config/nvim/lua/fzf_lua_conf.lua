MiniDeps.add({
    name = "fzf-lua",
    source = "ibhagwan/fzf-lua",
    checkout = "main",
    depends = { "nvim-tree/nvim-web-devicons" },
})

require("fzf-lua").setup({
    fzf_opts = {
        ["--info"] = "default",
    },
    grep = {
        rg_opts = '--hidden --column -g "!.git" --line-number --color=always --smart-case',
    },
})
