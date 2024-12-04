local lsp_cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_clients = {
    gopls = {
        filetype = {'go', 'gomod', 'gosum', 'gowork', 'gotmpl'},
        client_config = function(arg)
            return {
                name = 'gopls',
                cmd = {'gopls'},
                capabilities = lsp_cmp_capabilities,
                root_dir = vim.fs.root(arg.buf, {'go.mod', 'go.sum'}),
            }
        end
    },
    clangd = {
        filetype = {'c', 'cpp', 'objc', 'cuda', 'proto'},
        client_config = function(arg)
            return {
                name = 'clangd',
                cmd = {'clangd'},
                capabilities = lsp_cmp_capabilities,
            }
        end
    },
}

local function make_lsp_autocmd(filetype, client_config)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = filetype,
        callback = function(arg)
            if vim.fn.executable(client_config(arg).cmd[1]) then
                vim.lsp.start(client_config(arg))
            end
        end
    })
end

for _, config in pairs(lsp_clients) do
    make_lsp_autocmd(config.filetype, config.client_config)
end
