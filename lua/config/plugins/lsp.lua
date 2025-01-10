return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local lsp = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local lsps = {
                "lua_ls",
                "rust_analyzer",
                "gleam",
                "ts_ls"
            }

            for _, name in ipairs(lsps) do
                lsp[name].setup { capabilities = capabilities }
            end

            vim.keymap.set("n", "<space>ch", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "Toggle inlay hints" })
        end
    }
}
