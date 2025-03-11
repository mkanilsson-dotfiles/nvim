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
                "ts_ls",
                "zls",
                "marksman"
            }

            for _, name in ipairs(lsps) do
                lsp[name].setup { capabilities = capabilities }
            end

            lsp.emmet_language_server.setup {
                filetypes = {
                    "css",
                    "eruby",
                    "html",
                    "htmldjango",
                    "javascriptreact",
                    "less",
                    "pug",
                    "sass",
                    "scss",
                    "typescriptreact",
                    "htmlangular",
                    "razor",
                    "cshtml"
                }
            }
        end
    }
}
