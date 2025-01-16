---@class SwitcherOpts
---@field mappings table<string, string> Extensions mappings

---@type SwitcherOpts
local M = {
    mappings = {
        [".razor"] = ".razor.cs",
        [".cpp"] = ".h",
    }
}

local utils = require("utils")

--Retuns new filename with extensions swapped if extension match or nil
---@param filename string Current file
---@param old_extension string Extension to replace
---@param new_extension string Extension to use
---@return string|nil filename if current extension matches old_extension
M._get_new_file = function(filename, old_extension, new_extension)
    if utils.ends_width(filename, old_extension) then
        return string.sub(filename, 0, #filename - #old_extension) .. new_extension
    end

    return nil
end

---Opens filename if it isn't nil
---@param filename string|nil
M._try_edit = function(filename)
    if filename ~= nil then
        vim.cmd("edit " .. filename)
    end
end

---@param filename string|nil Filename to switch between, current file if nil
M.switch = function(filename)
    filename = filename or vim.fn.expand("%")

    -- Forward
    for old_extension, new_extension in pairs(M.mappings) do
        M._try_edit(M._get_new_file(filename, old_extension, new_extension))
    end

    -- Backwards
    for new_extension, old_extension in pairs(M.mappings) do
        M._try_edit(M._get_new_file(filename, old_extension, new_extension))
    end
end

return M
