return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text"
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dap.adapters.coreclr = {
                type = "executable",
                command = vim.fn.expand("/usr/bin/netcoredbg"),
                args = { "--interpreter=vscode" }
            }

            local razor_and_cs_default_config = {
                {
                    type = "coreclr",
                    name = "Launch - netcoredbg",
                    request = "launch",
                    preLaunchTask = "build",
                    cwd = function()
                        -- specify in a .mvim file
                        return vim.fn.getcwd()
                    end,
                    program = function()
                        -- specify in a .mvim file
                        return vim.fn.input("Path to dll: ",
                            vim.fn.getcwd() .. "/bin/Debug/net8.0/",
                            "file")
                    end,
                    env = {
                        ASPNETCORE_ENVIRONMENT = "Development"
                    }
                },
            }

            dap.configurations.cs = razor_and_cs_default_config
            dap.configurations.razor = razor_and_cs_default_config

            vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'WarningMsg', linehl = '', numhl = '' })

            dapui.setup()
            require("nvim-dap-virtual-text").setup {}

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    }
}
