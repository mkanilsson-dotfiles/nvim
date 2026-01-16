---@class FormatOptions
---@field enabled boolean
---@field ignored_directories string[]
local M = {
    enabled = true,
    ignored_directories = {}
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
                        for _, value in ipairs(M.ignored_directories) do
                            if string.find(vim.api.nvim_buf_get_name(0), value) then
                                return
                            end
                        end
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

---@param directories string[]
M.set_ignored_directories = function(directories)
    M.ignored_directories = directories
end

return M
