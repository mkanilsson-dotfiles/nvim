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
                    '--logLevel=Information',
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
                    capabilities = require("blink.cmp").get_lsp_capabilities(),
                    handlers = require 'rzls.roslyn_handlers',
                },
            }
        end
    }
}
