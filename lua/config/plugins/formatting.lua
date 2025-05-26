return {
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = { "prettier" },
                    ['*'] = { "lsp" }
                },
            })
        end
    }
}
