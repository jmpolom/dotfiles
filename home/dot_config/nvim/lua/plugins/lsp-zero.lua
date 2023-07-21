return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
                opts = {}, -- buggy; mason doesn't get setup without this
            },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    ensure_installed = {
                        "lua_ls",
                        "yamlls",
                    },
                },
            },
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jayp0521/mason-null-ls.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
            -- Snippet Collection (Optional)
            { "rafamadriz/friendly-snippets" },
            -- Signature support
            { "ray-x/lsp_signature.nvim" },
        },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})
            end)

            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()

            local null_ls = require("null-ls")
            local null_opts = lsp.build_options("null-ls", {})
            null_ls.setup({
                on_attach = function(client, bufnr)
                    null_opts.on_attach(client, bufnr)
                end,
                sources = {
                    null_ls.builtins.diagnostics.hadolint,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.jq,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.shellharden,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.stylua,
                },
            })
        end,
        keys = {
            { "<leader>F", "<cmd>:LspZeroFormat<cr>" },
        },
    }
}
