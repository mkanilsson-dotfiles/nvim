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
    }
}
