return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            { "nvim-tree/nvim-web-devicons", opts = {} }
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
        end,
    },
}
