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
                command = vim.fn.expand("~/opt/netcoredbg/netcoredbg"),
                args = { "--interpreter=vscode" }
            }

            dap.configurations.cs = {
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

            vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<space>dc", dap.continue, { desc = "Start/Continue" })
            vim.keymap.set("n", "<space>di", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<space>do", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<space>dt", dap.step_out, { desc = "Step out" })
            vim.keymap.set("n", "<space>ds", dap.close, { desc = "Stop" })
        end
    }
}
