return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        require("telescope").setup({
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

        vim.keymap.set("n", "<space><space>", require("telescope.builtin").find_files)
        vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags)
        vim.keymap.set("n", "<space>fc", function()
            require("telescope.builtin").find_files {
                cwd = vim.fn.stdpath("config")
            }
        end)

        local x = 4
        print(x)

        vim.keymap.set("n", "<space>cD", require("telescope.builtin").lsp_references)
        vim.keymap.set("n", "<space>ci", require("telescope.builtin").lsp_implementations)
        vim.keymap.set("n", "<space>,", require("telescope.builtin").buffers)
        vim.keymap.set("n", "<space>sp", require("telescope.builtin").live_grep)
    end
}
