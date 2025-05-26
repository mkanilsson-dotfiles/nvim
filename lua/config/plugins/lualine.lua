local utils = require("utils")

local function buffername()
    local buffer_name = vim.api.nvim_buf_get_name(0)

    if buffer_name == "" then
        return "[No Name]"
    end

    local oil_prefix = "oil://"

    if utils.starts_with(buffer_name, oil_prefix) then
        buffer_name = string.sub(buffer_name, #oil_prefix + 1)
    end

    local cwd = vim.fn.getcwd()

    if utils.starts_with(buffer_name, cwd) then
        local stripped = string.sub(buffer_name, #cwd + 2)
        if stripped == "" then
            return cwd
        end

        return stripped
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
