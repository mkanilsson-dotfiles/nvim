return {
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "isort", "black" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                },
                default_format_opts = {
                    lsp_format = "fallback"
                },
                notify_on_error = true,
                notify_no_formatters = true
            })
        end
    }
}
