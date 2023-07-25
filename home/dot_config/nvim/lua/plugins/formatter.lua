return {
    {
        "mhartington/formatter.nvim",
        event = "VeryLazy",
        config = function ()
            require("formatter").setup({
            filetype = {
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
