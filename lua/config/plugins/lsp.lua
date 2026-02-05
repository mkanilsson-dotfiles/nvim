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
            "mfussenegger/nvim-jdtls",
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            vim.lsp.config("qbels", {
                cmd = { vim.fn.expand("~/Documents/dev/rust/qbels/target/debug/qbels") },
                filetypes = { "qbe" },
                root_dir = vim.fs.root(0, { ".git" }),
                settings = {}
            })
            vim.lsp.enable("qbels")

            vim.lsp.config("rosetta-lsp", {
                cmd = { vim.fn.expand("~/Documents/dev/zig/rosetta/run_lsp.sh") },
                filetypes = { "rosetta" },
                root_dir = vim.fn.expand("~/Documents/dev/zig/rosetta"),
                settings = {}
            })
            vim.lsp.enable("rosetta-lsp")

            local lsps = {
                "lua_ls",
                "rust_analyzer",
                "gleam",
                "ts_ls",
                "marksman",
                "html",
                "gopls",
                "kotlin_language_server",
                "jdtls",
                "elp",
                "zls",
                "eslint",
                "tinymist",
                "clangd",
                "neocmake"
            }

            for _, name in ipairs(lsps) do
                vim.lsp.config(name, {
                    capabilities = capabilities,
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
                    "cshtml",
                }
            })
            vim.lsp.enable("emmet_language_server")

            vim.lsp.config("roslyn", {
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,

                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                        dotnet_enable_inlay_hints_for_indexer_parameters = true,
                        dotnet_enable_inlay_hints_for_literal_parameters = true,
                        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                        dotnet_enable_inlay_hints_for_other_parameters = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                    },
                },
                capabilities = capabilities,
            })
            vim.lsp.enable("roslyn")

            vim.lsp.config("sourcekit", {
                filetypes = { "swift", "objc", "objcpp" }
            })
            vim.lsp.enable("sourcekit")
        end
    }
}
