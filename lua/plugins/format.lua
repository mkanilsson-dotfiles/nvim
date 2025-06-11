local M = {
    enabled = true
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        ---@diagnostic disable-next-line: param-type-mismatch, missing-parameter
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    if M.enabled and vim.bo[args.buf].filetype ~= "razor" then
                        require("conform").format()
                    end
                end
            })
        end
    end
})

M.toggle = function()
    M.enabled = not M.enabled
end

return M
