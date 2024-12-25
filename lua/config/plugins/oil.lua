return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            {
                "echasnovski/mini.icons",
                opts = {}
            }
        },
        config = function()
            require("oil").setup({
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime"
                }
            })
            vim.keymap.set("n", "<space>.", function()
                vim.cmd { cmd = "Oil", args = { vim.fn.expand("%:p:h") } }
            end)
        end
    }
}
