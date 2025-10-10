return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" }
    },
    config = function()
        local t = require("telescope.themes").get_ivy {
            layout_config = {
                height = 15
            }
        }

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "%__virtual.cs$",
                    "%__virtual.html$",
                    "node_modules",
                    "vendor",
                    "target",
                    "bin/Debug",
                    "obj/Debug",
                    "bin/Release",
                    "obj/Release",
                    "%.git",
                    ".zig-cache",
                    "zig-out",
                    "Build/x86_64",
                    "Build/x86_64clang",
                    "Build/lagom",
                },
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-Enter>"] = require("telescope.actions").select_default,
                    }
                }
            },
            pickers = {
                find_files = {
                    theme = "ivy"
                },
                lsp_references = {
                    theme = "ivy"
                },
                lsp_implementations = {
                    theme = "ivy"
                },
                buffers = {
                    theme = "ivy"
                },
                live_grep = {
                    theme = "ivy"
                },
                commands = {
                    theme = "ivy"
                },
                diagnostics = {
                    theme = "ivy"
                },
            },
            extensions = {
                ["ui-select"] = {
                    t
                },
                ["todo-comments"] = {
                    t
                }
            }
        })

        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("todo-comments")
    end
}
