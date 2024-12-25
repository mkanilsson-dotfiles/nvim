return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.add({
                { "<space>b",  group = "Buffers" },
                { "<space>c",  group = "Code" },
                { "<space>ct", group = "Toggle" },
                { "<space>f",  group = "Find" },
                { "<space>p",  group = "Projects" },
                { "<space>g",  group = "Git" },
                { "<space>l",  group = "Lua" },
                { "<space>o",  group = "Open" },
                { "<space>q",  group = "QuickFix" },
                { "<space>s",  group = "Search" }
            })
        end
    }
}
