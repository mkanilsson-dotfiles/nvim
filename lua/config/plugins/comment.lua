return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                toggler = {
                    line = "<C-'>",
                    block = 'gbc',
                },
                opleader = {
                    line = "<C-'>",
                    block = "gbc"
                }
            }
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    }
}
