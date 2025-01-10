local path = vim.fn.stdpath("config") .. "/lua/plugins"

local handle = vim.loop.fs_scandir(path)
while true do
    local name, entity_type = vim.loop.fs_scandir_next(handle)
    if not name then break end
    if entity_type == 'file' and name ~= "autoload.lua" then
        local path = "plugins." .. name:gsub("%.lua", "")
        local plugin = require(path)
        if type(plugin) == "table" and plugin.setup then plugin.setup() end
    end
end
