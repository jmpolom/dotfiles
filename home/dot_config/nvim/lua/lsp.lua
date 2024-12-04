local lsp_cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_default_capabilities = vim.lsp.protocol.make_client_capabilities()
local runtime_capabilities = vim.tbl_deep_extend('force', nvim_default_capabilities, lsp_cmp_capabilities)

local function rustalyzer_workspace(arg)
    local cargo_crate_root = vim.fs.root(arg.buf, {'Cargo.toml'})

    if cargo_crate_root ~= nil then
        local cargo_cmd = {
            'cargo',
            'metadata',
            '--no-deps',
            '--format-version',
            '1',
            '--manifest-path',
            vim.fs.joinpath(cargo_crate_root ,'/Cargo.toml'),
        }

        local cargo_out = vim.system(cargo_cmd, {text = true, stderr = false}):wait()

        if cargo_out and cargo_out.stdout then
            local ws_root = vim.json.decode(cargo_out.stdout)

            if ws_root['workspace_root'] then
                local cargo_workspace_root = vim.fs.normalize(ws_root['workspace_root'])
                return cargo_workspace_root or cargo_crate_root
            end
        end
    end
end

local lsp_clients = {
    gopls = {
        filetypes = {'go', 'gomod', 'gowork', 'gotmpl'},
        client_config = function(arg)
            return {
                name = 'gopls',
                cmd = {'gopls'},
                capabilities = runtime_capabilities,
                root_dir = vim.fs.root(arg.buf, {'go.mod', 'go.sum'}),
            }
        end
    },
    clangd = {
        filetypes = {'c', 'cpp', 'objc', 'cuda', 'proto'},
        client_config = function(arg)
            return {
                name = 'clangd',
                cmd = {'clangd'},
                capabilities = runtime_capabilities,
                root_dir = vim.fs.root(arg.buf, {
                    '.clangd',
                    '.clang-tidy',
                    '.clang-format',
                    'compile_commands.json',
                    'compile_flags.txt',
                    'configure.ac'
                }),
            }
        end
    },
    lua_language_server = {
        filetypes = {'lua'},
        client_config = function(arg)
            return {
                name = 'lua-language-server',
                cmd = {'lua-language-server'},
                capabilities = runtime_capabilities,
                root_dir = vim.fs.root(arg.buf, {
                    '.luarc.json',
                    '.luarc.jsonc',
                    '.luacheckrc',
                    '.stylua.toml',
                    'stylua.toml',
                    'selene.toml',
                    'selene.yml',
                    'lua/'
                }),
                on_attach = function(client, _)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                end,
                settings = {
                    Lua = {}
                },
            }
        end
    },
    rust_analyzer = {
        filetypes = {'rust'},
        client_config = function(arg)
            return {
                name = 'rust-analyzer',
                cmd = {'rust-analyzer'},
                capabilities = runtime_capabilities,
                root_dir = rustalyzer_workspace(arg)
            }
        end
    },
}

local function make_lsp_autocmd(filetypes, client_config)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function(arg)
            if vim.fn.executable(client_config(arg).cmd[1]) then
                vim.lsp.start(client_config(arg))
            end
        end
    })
end

for _, config in pairs(lsp_clients) do
    make_lsp_autocmd(config.filetypes, config.client_config)
end
