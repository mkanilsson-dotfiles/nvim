return {
    {
        "jlcrochet/vim-razor"
    },
    {
        "seblj/roslyn.nvim",
        ft = "cs",
        dependencies = {
            {
                "tris203/rzls.nvim",
                branch = "pullDiags",
                config = function()
                    require("rzls").setup({
                        on_attach = function() end,
                        capabilities = require("blink.cmp").get_lsp_capabilities()
                    })
                end
            }
        },
        config = function()
            require('roslyn').setup {
                args = {
                    '--logLevel=Warning',
                    '--stdio',
                    '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
                    '--razorSourceGenerator=' .. vim.fs.joinpath(
                        vim.fn.stdpath 'data' --[[@as string]],
                        'mason',
                        'packages',
                        'roslyn',
                        'libexec',
                        'Microsoft.CodeAnalysis.Razor.Compiler.dll'
                    ),
                    '--razorDesignTimePath=' .. vim.fs.joinpath(
                        vim.fn.stdpath 'data' --[[@as string]],
                        'mason',
                        'packages',
                        'rzls',
                        'libexec',
                        'Targets',
                        'Microsoft.NET.Sdk.Razor.DesignTime.targets'
                    ),
                },
                config = {
                    -- capabilities = require("blink.cmp").get_lsp_capabilities(),
                    handlers = require 'rzls.roslyn_handlers',
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
                }

            }


            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                group = vim.api.nvim_create_augroup("IgnoreUnsavedChanges", { clear = true }),
                pattern = "*__virtual.html",
                callback = function()
                    vim.bo.buftype = "nofile"
                end
            })

            vim.api.nvim_create_autocmd("BufWriteCmd", {
                group = vim.api.nvim_create_augroup("DontSave__virtualFiles", { clear = true }),
                pattern = "*__virtual.html",
                callback = function()
                    vim.cmd('echom "Skipping save for __virtual.html file"')
                end
            })
        end
    }
}
