local utils = require("utils")

local function add_prefix(path, is_wasm_tool)
    if is_wasm_tool then
        return "[decompiled] " .. path
    end

    return path
end

local function buffername()
    local buffer_name = vim.api.nvim_buf_get_name(0)

    if buffer_name == "" then
        return "[No Name]"
    end

    local oil_prefix = "oil://"
    if utils.starts_with(buffer_name, oil_prefix) then
        buffer_name = string.sub(buffer_name, #oil_prefix + 1)
    end

    local is_wasm_tool = false
    local wasm_tool_prefix = "wasm-tools://"
    if utils.starts_with(buffer_name, wasm_tool_prefix) then
        buffer_name = string.sub(buffer_name, #wasm_tool_prefix + 1)
        is_wasm_tool = true
    end

    local cwd = vim.fn.getcwd()

    if utils.starts_with(buffer_name, cwd) then
        local stripped = string.sub(buffer_name, #cwd + 2)
        if stripped == "" then
            return add_prefix(cwd, is_wasm_tool)
        end

        return add_prefix(stripped, is_wasm_tool)
    end

    return buffer_name
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup {
                options = {
                    theme = "gruvbox",
                    component_separators = "",
                    section_separators = ""
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "diff", "diagnostics" },
                    lualine_c = { buffername },
                    lualine_x = { "encoding", "fileformat" },
                    lualine_y = { "filetype", "location" },
                    lualine_z = { "searchcount", "selectioncount" },
                }
            }
        end
    }
}
