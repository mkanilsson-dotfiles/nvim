return {
    {
        "seblyng/roslyn.nvim",
        ft = { "cs", "razor" },
        config = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                group = vim.api.nvim_create_augroup("IgnoreUnsavedChanges", { clear = true }),
                pattern = "*__virtual.html",
                callback = function()
                    vim.bo.buftype = "nofile"
                end
            })

            vim.api.nvim_create_autocmd("BufWriteCmd", {
                group = vim.api.nvim_create_augroup("DontSave__virtualFiles", { clear = true }),
                pattern = "*__virtual.html",
                callback = function()
                    vim.cmd('echom "Skipping save for __virtual.html file"')
                end
            })
        end,
        init = function()
            -- We add the Razor file types before the plugin loads.
            vim.filetype.add({
                extension = {
                    razor = "razor",
                    cshtml = "razor",
                },
            })
        end,
    },
}
