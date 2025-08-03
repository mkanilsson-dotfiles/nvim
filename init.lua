require("config.lazy")
require("plugins.autoload")
require("keybindings")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showtabline = 0
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.iskeyword:remove("_")

vim.g.markdown_fenced_languages = {
    'scl'
}

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

vim.filetype.add({
    extension = {
        lalrpop = "lalrpop",
        scl = "scl",
        qbe = "qbe",
        ssa = "qbe",
    }
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "www/Recipes/*.txt",
    callback = function()
        vim.bo.filetype = "json"
    end,
})
