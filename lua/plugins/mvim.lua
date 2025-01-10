---@class MvimOptions
---@field format_on_save boolean?
---@field debuggers MvimDebugger?

---@class MvimDebugger
---@field cs MvimCsDebugger[]?

---@class MvimCsDebugger
---@field cwd string?
---@field dll string?
---@field name string?


local M = {
    ---@type MvimOptions
    options = {}
}

---@return MvimOptions: Parsed options
M._parse_file = function()
    local path = vim.fn.getcwd() .. "/.mvim"
    local file = io.open(path)

    local opts = {}

    if file then
        opts = vim.json.decode(file:read("*a"))
    end

    M._populate_defaults(opts)
end

---@param opts MvimOptions
M._populate_defaults = function(opts)
    if opts.format_on_save == nil then
        opts.format_on_save = true
    end

    opts.debuggers = opts.debuggers or {}

    M.options = opts
end

---@param opts MvimCsDebugger[]
M._configure_cs_debuggers = function(opts)
    local dap = require("dap")

    local configurations = {}

    for i, instance in ipairs(opts) do
        table.insert(configurations, {
            type = "coreclr",
            name = instance.name or ("Launch - netcoredbg " .. i),
            request = "launch",
            preLaunchTask = "build",
            cwd = function()
                return vim.fn.getcwd() .. (instance.cwd or "")
            end,
            program = function()
                if instance.dll then
                    return vim.fn.getcwd() .. instance.dll
                end

                return vim.fn.input("Path to dll: ", vim.fn.getcwd(), "file")
            end,
            env = {
                ASPNETCORE_ENVIRONMENT = "Development"
            }
        })
    end

    dap.configurations.cs = configurations
end

M.setup = function()
    vim.api.nvim_create_autocmd("DirChanged", {
        group = vim.api.nvim_create_augroup("DirChange", { clear = true }),
        pattern = "*",
        callback = M.reload,
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = ".mvim",
        command = "setfiletype json"
    })

    vim.api.nvim_create_autocmd({ "BufWritePost", "FileChangedShellPost" }, {
        pattern = ".mvim",
        callback = M.reload,
    })

    M.reload()
end

M.reload = function()
    M._parse_file()

    local format = require("plugins.format")
    format.enabled = M.options.format_on_save

    for lang, configurations in pairs(M.options.debuggers) do
        if lang == "cs" then
            M._configure_cs_debuggers(configurations)
        else
            error("mvim: Unknown debugger language \"" .. lang .. "\"")
        end
    end

    vim.notify("mvim loaded", vim.log.levels.INFO)
end

return M
