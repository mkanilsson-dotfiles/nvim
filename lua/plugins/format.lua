local state = true

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        ---@diagnostic disable-next-line: param-type-mismatch, missing-parameter
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    if state then
                        vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                    end
                end
            })
        end
    end
})

vim.keymap.set("n", "<space>ctf", function()
    state = not state
end, { desc = "Toggle format on save" })

vim.api.nvim_create_autocmd("DirChanged", {
    group = vim.api.nvim_create_augroup("DirChange", { clear = true }),
    pattern = "*",
    callback = function(args)
        if vim.loop.fs_stat(".disable-format-on-save") then
            state = false
        else
            state = true
        end
    end,
})
