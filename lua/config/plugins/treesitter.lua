return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "asm",
                    "c",
                    "c_sharp",
                    "dart",
                    "dockerfile",
                    "gleam",
                    "go",
                    "gomod",
                    "gosum",
                    "hyprlang",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "menhir",
                    "nasm",
                    "ocaml",
                    "python",
                    "query",
                    "rust",
                    "vim",
                    "vimdoc",
                    "zig",
                    "lalrpop"
                },
                ignore_install = {},
                modules = {},
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 500 * 1024 -- 500 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = true,
                },
                playground = {
                    enable = true,
                    updatetime = 25
                }
            }
        end
    }
}
