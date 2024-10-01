local function config()
    local lsp_zero = require("lsp-zero")

    local lsp_attach = function(client, bufnr)
        lsp_zero.buffer_autoformat()

        local opts = {buffer = bufnr}

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    end

    lsp_zero.extend_lspconfig({
        sign_text = {
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = "»",
        },
        lsp_attach = lsp_attach,
        float_border = "rounded",
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    })

    require("mason").setup({})
    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
        }
    })

    local cmp = require("cmp")
    local cmp_action = lsp_zero.cmp_action()

    -- this is the function that loads the extra snippets
    -- from rafamadriz/friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        sources = {
            {name = "path"},
            {name = "nvim_lsp"},
            {name = "luasnip", keyword_length = 2},
            {name = "buffer", keyword_length = 3},
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            -- confirm completion item
            ["<Enter>"] = cmp.mapping.confirm({ select = true }),

            -- trigger completion menu
            ["<C-Space>"] = cmp.mapping.complete(),

            -- scroll up and down the documentation window
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),

            -- navigate between snippet placeholders
            ["<C-f>"] = cmp_action.luasnip_jump_forward(),
            ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        }),
        -- note: if you are going to use lsp-kind (another plugin)
        -- replace the line below with the function from lsp-kind
        formatting = lsp_zero.cmp_format({details = true}),
    })
end

return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = false,

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "L3MON4D3/LuaSnip",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },

    config=config,
}
