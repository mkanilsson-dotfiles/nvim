local M = {}

M._get_hidden_buffers = function()
    local hidden_buffers = {}

    local shown_windows = vim.api.nvim_list_wins()
    local show_bufs = {}

    local buffers = vim.api.nvim_list_bufs()

    for _, win in ipairs(shown_windows) do
        show_bufs[vim.api.nvim_win_get_buf(win)] = true
    end

    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) and show_bufs[buf] ~= true then
            table.insert(hidden_buffers, buf)
        end
    end

    return hidden_buffers
end

M.delete = function()
    local to_close = M._get_hidden_buffers()

    if #to_close == 0 then
        print("No hidden buffers to delete")
        return
    end

    local answer = vim.fn.confirm("Do you want to close " .. #to_close .. " buffers?", "&Yes\n&No", 2)

    if answer == 1 then
        for _, buf in ipairs(to_close) do
            local status, err = pcall(function()
                vim.api.nvim_buf_delete(buf, { force = false, unload = false })
            end)

            if not status then
                vim.print("Failed to delete buffer \"" ..
                    vim.api.nvim_buf_get_name(buf) .. "\": Might have unsaved changes")
            end
        end
    end
end

return M
