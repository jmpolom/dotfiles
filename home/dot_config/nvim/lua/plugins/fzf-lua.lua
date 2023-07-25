return {
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            fzf_opts = {
                ["--info"] = "default",
                grep = {
                    rg_opts = [[--hidden --column -g "!.git" --line-number --color=always --smart-case]],
                },
            }
        },
    }
}
