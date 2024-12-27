return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "%__virtual.cs$", "%__virtual.html$" }
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
            }
        })

        vim.keymap.set("n", "<space><space>", require("telescope.builtin").find_files, { desc = "Find files" })
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
