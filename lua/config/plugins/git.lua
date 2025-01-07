return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local neogit = require("neogit")

            neogit.setup {
                -- Hides the hints at the top of the status buffer
                disable_hint = true,
                graph_style = "unicode",
                mappings = {
                    popup = {
                        ["p"] = "PushPopup",
                        ["f"] = "FetchPopup",
                        ["F"] = "PullPopup",
                    },
                },
            }


            vim.keymap.set("n", "<space>gg", neogit.open, { desc = "Git" })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require('blame').setup {}
            vim.keymap.set("n", "<space>gB", "<CMD>BlameToggle<CR>", { desc = "Git Blame" })
        end,
    },
}
