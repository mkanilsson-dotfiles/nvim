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
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("qbels", {
                cmd = { vim.fn.expand("~/Documents/dev/rust/qbels/target/debug/qbels") },
                filetypes = { "qbe" },
                root_dir = vim.fs.root(0, { ".git" }),
                settings = {}
            })
            vim.lsp.enable("qbels")

            local lsps = {
                "lua_ls",
                "rust_analyzer",
                "gleam",
                "ts_ls",
                "zls",
                "marksman",
                "html"
            }

            for _, name in ipairs(lsps) do
                vim.lsp.config(name, {
                    capabilities = capabilities
                })
                vim.lsp.enable(name)
            end

            vim.lsp.config("emmet_language_server", {
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
            })
            vim.lsp.enable("emmet_language_server")

            vim.lsp.config("clangd", {
                cmd = { "/home/marcus/Documents/dev/others/serenity/Toolchain/Local/clang/bin/clangd" },
                capabilities = capabilities,
            })
            vim.lsp.enable("clangd")
        end
    }
}
