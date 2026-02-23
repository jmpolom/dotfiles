MiniDeps.add({
    name = "nvim-cmp",
    source = "hrsh7th/nvim-cmp",
    checkout = "main",
    depends = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "ray-x/lsp_signature.nvim",
    },
})

local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    completion = {
        completeopt = "menu,menuone,noinsert,noselect"
    },
    sources = {
        {name = "path"},
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {name = "buffer", keyword_length = 3},
        {name = "luasnip", keyword_length = 2},
    },
    mapping = cmp.mapping.preset.insert({
        -- confirm completion item
        ["<CR>"] = cmp.mapping.confirm({select = false}),

        -- toggle completion menu
        ["<C-S-Space>"] = cmp.mapping.complete(),

        -- move in list
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),

        -- scroll documention window
        ["<C-f>"] = cmp.mapping.scroll_docs(-5),
        ["<C-d>"] = cmp.mapping.scroll_docs(5),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
})
