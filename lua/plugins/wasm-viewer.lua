local M = {}

M.open_wasm = function()
    local filepath = vim.fn.expand("%:p")

    local cmd = string.format("wasm-tools print --color never '%s' 2>&1", filepath)
    local handle = io.popen(cmd)

    if handle == nil then
        M._log_error("Failed to parse WASM file")
        return
    end

    local output = handle:read("*a")
    handle:close()

    local bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(bufnr, "wasm-tools://" .. filepath)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(output, "\n"))

    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'wat')
    vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
    vim.api.nvim_buf_set_option(bufnr, 'readonly', true)
    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)

    vim.api.nvim_win_set_buf(0, bufnr)
end

M._log_error = function(message)
    vim.notify("[WASM] " .. message, vim.log.levels.ERROR)
end

M.setup = function()
    vim.api.nvim_create_autocmd("BufReadPre", {
        pattern = "*.wasm",
        callback = function()
            vim.schedule(function()
                M.open_wasm()
            end)
        end,
        desc = "Auto-open WASM files with wasm-tools"
    })
end

return M
