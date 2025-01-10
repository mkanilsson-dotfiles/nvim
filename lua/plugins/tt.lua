local M = {
    state = {
        buf = nil,
        win = nil
    }
}

M.toggle_terminal = function()
    if M.state.win and vim.api.nvim_win_is_valid(M.state.win) then
        vim.api.nvim_win_close(M.state.win, true)
        M.state.win = nil
    else
        if not M.state.buf or not vim.api.nvim_buf_is_valid(M.state.buf) then
            M.state.buf = vim.api.nvim_create_buf(false, true)
        end

        vim.cmd.vnew();
        M.state.win = vim.api.nvim_get_current_win()
        vim.cmd.wincmd("J")
        vim.api.nvim_win_set_height(M.state.win, 15)
        vim.api.nvim_win_set_buf(M.state.win, M.state.buf)

        if vim.bo[M.state.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end

        vim.api.nvim_set_option_value("number", false, {
            win = M.state.win
        })

        vim.api.nvim_set_option_value("winhl", "Normal:Normal", {
            win = M.state.win
        })

        vim.api.nvim_set_option_value("relativenumber", false, {
            win = M.state.win
        })
    end
end

return M
