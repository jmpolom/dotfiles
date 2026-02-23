return {
    filetypes = {'go', 'gomod', 'gowork', 'gotmpl'},
    name = 'gopls',
    cmd = {'gopls'},
    root_dir = function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, {'go.mod', 'go.sum'}))
    end,
}
