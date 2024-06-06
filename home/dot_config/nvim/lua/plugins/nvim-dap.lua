return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.configurations.lua = {
                {
                  type = 'nlua',
                  request = 'attach',
                  name = "Attach to running Neovim instance",
                }
            }

            dap.adapters.nlua = function(callback, config)
                callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
            end

            -- dynamic keymaps
            vim.keymap.set("n", "<F8>", "<cmd>lua require(\"dap\").toggle_breakpoint()<CR>", { noremap = true })
            vim.keymap.set("n", "<F9>", "<cmd>lua require(\"dap\").continue()<CR>", { noremap = true })
            vim.keymap.set("n", "<F6>", "<cmd>lua require(\"dap\").step_over()<CR>", { noremap = true })
            vim.keymap.set("n", "<F7>", "<cmd>lua require(\"dap\").step_into()<CR>", { noremap = true })
            vim.keymap.set("n", "<F12>", "<cmd>lua require(\"dap.ui.widgets\").hover()<CR>", { noremap = true })
        end,
        event = "VeryLazy",
    }
}
