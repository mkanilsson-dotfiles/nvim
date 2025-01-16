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
                    "build",
                    "bin/Debug",
                    "obj/Debug",
                    "%.git"
                },
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
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
            },
            extensions = {
                ["ui-select"] = {
                    t
                }
            }
        })

        require("telescope").load_extension("ui-select")
    end
}
