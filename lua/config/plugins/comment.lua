return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                opleader = {
                    line = "<C-'>",
                    block = "gbc"
                }
            }
        end
    }
}
