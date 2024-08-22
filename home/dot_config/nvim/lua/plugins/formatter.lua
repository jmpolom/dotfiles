return {
    {
        "mhartington/formatter.nvim",
        config = function ()
            require("formatter").setup({
            filetype = {
                css = {
                    require("formatter.filetypes.html").prettier
                },
                html = {
                    require("formatter.filetypes.html").prettier
                },
                json = {
                    require("formatter.filetypes.json").jq
                },
                lua = {
                    require("formatter.filetypes.lua").stylua
                },
                python = {
                    require("formatter.filetypes.python").black
                },
                sh = {
                    require("formatter.filetypes.sh").shfmt
                },
            },
            })
        end,
    }
}
