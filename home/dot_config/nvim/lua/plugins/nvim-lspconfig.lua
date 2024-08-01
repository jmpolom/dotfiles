return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig.clangd.setup({
                capabilities = lsp_capabilities,
            })

            lspconfig.gopls.setup({
                capabilities = lsp_capabilities,
            })

            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
                on_init = function(client)
                  local path = client.workspace_folders[1].name
                  -- TODO: vim.loop is deprecated so this needs to be fixed soon
                  if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                      Lua = {
                        runtime = {
                          -- Tell the language server which version of Lua you're using
                          -- (most likely LuaJIT in the case of Neovim)
                          version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                          checkThirdParty = false,
                          library = {
                            vim.env.VIMRUNTIME
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                          }
                          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                          -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                      }
                    })
                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                  end
                  return true
                end,
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
