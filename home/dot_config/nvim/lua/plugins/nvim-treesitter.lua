return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "arduino",
                "bash",
                "dockerfile",
                "fish",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gowork",
                "ini",
                "javascript",
                "jq",
                "json",
                "lua",
                "make",
                "markdown",
                "python",
                "regex",
                "rust",
            }
        },
        enabled = false,
    }
}
