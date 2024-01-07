return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = lsp_capabilities,
            })
            lspconfig.yamlls.setup({
               capabilities = lsp_capabilities,
            })
        end,
    }
}
