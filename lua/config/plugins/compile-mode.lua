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

        vim.keymap.set("n", "<space>pc", function()
            vim.cmd { cmd = "Compile" }
            vim.cmd.wincmd("J")
            vim.api.nvim_win_set_height(0, 15)
        end, { desc = "Compile" })
    end
}
