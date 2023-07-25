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
            {
                "jose-elias-alvarez/null-ls.nvim",
                dependencies = {
                   "nvim-lua/plenary.nvim",
                },
                config = function()
                    local null_ls = require("null-ls")

                    null_ls.setup({
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
            },
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

            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = ''
            })

            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = {
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
            })

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero.cmp').action()

            require('luasnip.loaders.from_vscode').lazy_load()
            vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    {name = 'path'},
                    {name = 'nvim_lsp'},
                    {name = 'nvim_lua'},
                    {name = 'buffer', keyword_length = 3},
                    {name = 'luasnip', keyword_length = 2},
                },
                mapping = {
                    -- confirm completion item
                    ['<CR>'] = cmp.mapping.confirm({select = false}),

                    -- toggle completion menu
                    ['<C-e>'] = cmp_action.toggle_completion(),

                    -- tab complete
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- navigate between snippet placeholder
                    ['<C-d>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    -- scroll documention window
                    ['<C-f>'] = cmp.mapping.scroll_docs(-5),
                    ['<C-d>'] = cmp.mapping.scroll_docs(5),
                },
            })
        end,
        keys = {
            { "<leader>F", "<cmd>:LspZeroFormat<cr>" },
        },
    }
}
