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
    if utils.ends_with(filename, old_extension) then
        return string.sub(filename, 0, #filename - #old_extension) .. new_extension
    end

    return nil
end

---Opens filename if it isn't nil
---@param filename string|nil
---@return boolean is_opened true if opened for edit
M._try_edit = function(filename)
    if filename ~= nil and vim.loop.fs_stat(filename) then
        vim.cmd("edit " .. filename)
        return true
    end

    return false
end

---@param filename string|nil Filename to switch between, current file if nil
M.switch = function(filename)
    filename = filename or vim.fn.expand("%")

    -- Forward
    for old_extension, new_extension in pairs(M.mappings) do
        if M._try_edit(M._get_new_file(filename, old_extension, new_extension)) then return end
    end

    -- Backwards
    for new_extension, old_extension in pairs(M.mappings) do
        if M._try_edit(M._get_new_file(filename, old_extension, new_extension)) then return end
    end
end

return M
