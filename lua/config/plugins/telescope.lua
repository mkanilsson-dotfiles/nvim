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

        vim.keymap.set("n", "<space><space>", function()
            require("telescope.builtin").find_files {
                hidden = true,
                no_ignore = true
            }
        end, { desc = "Find files" })

        vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "Help" })
        vim.keymap.set("n", "<space>fm", require("telescope.builtin").man_pages, { desc = "Man page" })
        vim.keymap.set("n", "<space>fc", function()
            require("telescope.builtin").find_files {
                cwd = vim.fn.stdpath("config")
            }
        end, { desc = "Find files (config)" })

        vim.keymap.set("n", "<space>cD", require("telescope.builtin").lsp_references, { desc = "Find references" })
        vim.keymap.set("n", "<space>ci", require("telescope.builtin").lsp_implementations, {
            desc = "Find implementations"
        })

        vim.keymap.set("n", "<space>,", function()
            require("telescope.builtin").buffers {
                ignore_current_buffer = true
            }
        end, { desc = "Find buffer" })
        vim.keymap.set("n", "<space>sp", require("telescope.builtin").live_grep, { desc = "Search" })
    end
}
