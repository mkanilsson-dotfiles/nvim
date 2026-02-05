local utils = require("utils")

---@class MvimOptions
---@field format_on_save boolean?
---@field format_on_save_ignored_directories string[]?
---@field copilot boolean?
---@field debuggers MvimDebugger?
---@field lsp table<string, any>?

---@class MvimDebugger
---@field cs MvimCsDebugger[]?

---@class MvimCsDebugger
---@field cwd string?
---@field dll string?
---@field name string?
---@field prelanch_cmd string[]?
---@field env { name: string, value: string }[]?

local M = {
    ---@type MvimOptions
    options = {},
    current_path = ""
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

    if opts.format_on_save_ignored_directories == nil then
        opts.format_on_save_ignored_directories = {}
    end

    if opts.copilot == nil then
        opts.copilot = false
    end

    opts.debuggers = opts.debuggers or {}
    opts.lsp = opts.lsp or {}

    if opts.dos == nil then
        opts.dos = false
    end

    if opts.eol == nil then
        opts.eol = false
    end

    M.options = opts
end

---@param opts MvimCsDebugger[]
M._configure_cs_debuggers = function(opts)
    local dap = require("dap")

    local configurations = {}

    for i, instance in ipairs(opts) do
        local allEnvs = instance.env or {}
        allEnvs["ASPNETCORE_ENVIRONMENT"] = "Development"

        table.insert(configurations, {
            type = "coreclr",
            name = instance.name or ("Launch - netcoredbg " .. i),
            request = "launch",
            preLaunchTask = "build",
            cwd = function()
                return vim.fn.getcwd() .. M._add_path_prefix(instance.cwd or "")
            end,
            program = function()
                if instance.dll then
                    return vim.fn.getcwd() .. M._add_path_prefix(instance.dll)
                end

                return vim.fn.input("Path to dll: ", vim.fn.getcwd(), "file")
            end,
            env = allEnvs
        })
    end

    dap.configurations.cs = configurations
    dap.configurations.razor = configurations
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
    local new_path = vim.fn.getcwd();
    local is_new_project = M.current_path ~= new_path
    M.current_path = new_path

    M._parse_file()

    if is_new_project then
        local format = require("plugins.format")
        format.enabled = M.options.format_on_save
        format.set_ignored_directories(M.options.format_on_save_ignored_directories)

        if M.options.copilot then
            vim.cmd([[Copilot enable]])
        else
            vim.cmd([[Copilot disable]])
        end
    end

    for lang, configurations in pairs(M.options.debuggers) do
        if lang == "cs" then
            M._configure_cs_debuggers(configurations)
        else
            error("mvim: Unknown debugger language \"" .. lang .. "\"")
        end
    end

    for lsp, config in pairs(M.options.lsp) do
        vim.lsp.config(lsp, config)
        vim.lsp.enable(lsp)
    end

    M._log("loaded")
end

M._log = function(message)
    vim.notify("[MVIM] " .. message, vim.log.levels.INFO)
end

M._add_path_prefix = function(path)
    if not utils.starts_with(path, "/") then
        return path .. "/"
    end

    return path
end

return M
