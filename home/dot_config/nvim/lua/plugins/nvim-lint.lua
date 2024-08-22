return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                css = {
                    "stylelint",
                },
                dockerfile = {
                    "hadolint",
                },
                html = {
                    "tidy",
                },
                json = {
                    "jsonlint",
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
                    require("lint").try_lint(nil,{ignore_errors = true})
                end,
            })
        end,
    }
}
