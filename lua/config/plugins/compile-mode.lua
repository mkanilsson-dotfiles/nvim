return {
    "ej-shafran/compile-mode.nvim",
    tag = "v5.4",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
        ---@type CompileModeOpts
        vim.g.compile_mode = {
            baleia_setup = true,
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "compilation",
            callback = function()
                vim.cmd.wincmd("J")
                vim.api.nvim_win_set_height(0, 15)
            end
        })
    end
}
