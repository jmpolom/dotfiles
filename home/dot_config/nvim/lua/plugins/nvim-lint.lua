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

            -- local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "" }
            -- for type, icon in pairs(signs) do
            --   local hl = "DiagnosticSign" .. type
            --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            -- end

            -- vim.diagnostic.config({
            --     float = {
            --         style = 'minimal',
            --         border = 'rounded',
            --         source = 'always',
            --         prefix = '',
            --     },
            --     signs = {
            --         text = {
            --             [vim.diagnostic.severity.ERROR] = 'EE',
            --         },
            --     },
            -- })

            vim.api.nvim_create_autocmd({
                "BufEnter",
                "BufWritePost",
                "TextChanged",
                "TextChangedI",
            }, {
                callback = function()
                    require("lint").try_lint(_,{ignore_errors=true})
                end,
            })
        end,
    }
}
