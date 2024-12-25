require("config.lazy")
require("plugins.autoload")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "<space>ls", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<space>cf", vim.lsp.buf.format)

vim.keymap.set("n", "<space>qn", "<cmd>cnext<CR>")
vim.keymap.set("n", "<space>qp", "<cmd>cprev<CR>")

vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set('t', '<esc><esc>', "<C-\\><C-n><C-w>h")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

vim.opt.iskeyword:remove("_")

vim.keymap.set("n", "<space>bd", function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_loaded(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
    end
end)
