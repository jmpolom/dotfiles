return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                dockerfile = {
                    "hadolint",
                },
                markdown = {
                    "vale",
                },
                python = {
                    "flake8",
                },
                sh = {
                    "shellcheck",
                },
            }

            vim.api.nvim_create_autocmd({
                "BufEnter",
                "BufWritePost",
                "TextChanged",
                "TextChangedI",
            }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
        event = "VeryLazy",
    }
}
