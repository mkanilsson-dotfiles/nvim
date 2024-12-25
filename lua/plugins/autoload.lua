local path = vim.fn.stdpath("config") .. "/lua/plugins"

local handle = vim.loop.fs_scandir(path)
while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end
    if type == 'file' and name ~= "autoload.lua" then
        require("plugins." .. name:gsub("%.lua", ""))
    end
end
