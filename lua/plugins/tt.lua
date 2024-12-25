-- Create a terminal buffer and window if not already created
local state = {
    buf = nil,
    win = nil
}

local toggle_terminal = function()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
    else
        if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
            state.buf = vim.api.nvim_create_buf(false, true)
        end

        vim.cmd.vnew();
        state.win = vim.api.nvim_get_current_win()
        vim.cmd.wincmd("J")
        vim.api.nvim_win_set_height(state.win, 15)
        vim.api.nvim_win_set_buf(state.win, state.buf)

        if vim.bo[state.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end

        vim.api.nvim_set_option_value("number", false, {
            win = state.win
        })

        vim.api.nvim_set_option_value("winhl", "Normal:Normal", {
            win = state.win
        })

        vim.api.nvim_set_option_value("relativenumber", false, {
            win = state.win
        })
    end
end

vim.keymap.set('n', '<space>ot', toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
