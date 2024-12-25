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
end)
