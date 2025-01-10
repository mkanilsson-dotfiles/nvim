---@diagnostic disable: missing-fields
local set = vim.keymap.set

-- Lua
set("n", "<space>ls", "<cmd>source %<CR>")
set("n", "<space>x", ":.lua<CR>", { desc = "Execute lua" })
set("v", "<space>x", ":lua<CR>", { desc = "Execute lua" })

-- Code
set("n", "<space>ca", vim.lsp.buf.code_action, {
    desc = "Code action"
})
set("n", "<space>cr", vim.lsp.buf.rename, { desc = "Rename" })
set("n", "<space>cf", vim.lsp.buf.format, { desc = "format" })
set("n", "<space>ch", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
set("n", "<space>ctf", require("plugins.format").toggle, { desc = "Toggle format on save" })

set("n", "<space>cD", require("telescope.builtin").lsp_references, { desc = "Find references" })
set("n", "<space>ci", require("telescope.builtin").lsp_implementations, {
    desc = "Find implementations"
})

-- Git
set("n", "<space>gg", require("neogit").open, { desc = "Git" })
set("n", "<space>gB", "<CMD>BlameToggle<CR>", { desc = "Git Blame" })

-- Buffers
set("n", "<space>bd", function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_loaded(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
    end
end, { desc = "Delete buffer" })

set("n", "<space>bD", require("plugins.delete_buffers").delete, { desc = "Delete all other buffers" })

set("n", "<space>bB", function()
    require("telescope.builtin").buffers {
        show_all_buffers = true
    }
end, { desc = "Find all buffer" })

-- QuickFix
set("n", "<space>qn", "<cmd>cnext<CR>", { desc = "QuickFix next" })
set("n", "<space>qp", "<cmd>cprev<CR>", { desc = "QuickFix prev" })

-- Open
set('n', '<space>ot', require("plugins.tt").toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })

-- Find
set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "Help" })
set("n", "<space>fm", require("telescope.builtin").man_pages, { desc = "Man page" })
set("n", "<space>fc", function()
    require("telescope.builtin").find_files {
        cwd = vim.fn.stdpath("config")
    }
end, { desc = "Find files (config)" })

-- Search
set("n", "<space>sp", require("telescope.builtin").live_grep, { desc = "Project" })

-- Project
set("n", "<space>pc", "<CMD>Compile<CR>", { desc = "Compile" })
set("n", "<space>pp", require("telescope").extensions.projects.projects, {
    desc = "List projects"
})

-- Debug
set("n", "<space>db", require("dap").toggle_breakpoint, { desc = "Toggle Breakpoint" })
set("n", "<space>dc", require("dap").continue, { desc = "Start/Continue" })
set("n", "<space>di", require("dap").step_into, { desc = "Step into" })
set("n", "<space>do", require("dap").step_over, { desc = "Step over" })
set("n", "<space>dt", require("dap").step_out, { desc = "Step out" })
set("n", "<space>ds", require("dap").close, { desc = "Stop" })

-- QoL
set({ "n", "v" }, "j", "gj")
set({ "n", "v" }, "k", "gk")
set("v", ">", ">gv")
set("v", "<", "<gv")
set('t', '<esc><esc>', "<C-\\><C-n><C-w>h")

set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })

set("n", "<space><space>", function()
    require("telescope.builtin").find_files {
        hidden = true,
        no_ignore = true
    }
end, { desc = "Find files" })

set("n", "<space>,", function()
    require("telescope.builtin").buffers {
        ignore_current_buffer = true
    }
end, { desc = "Find buffer" })

set("n", "<space>.", function()
    vim.cmd { cmd = "Oil", args = { vim.fn.expand("%:p:h") } }
end, { desc = "Open current directory" })
