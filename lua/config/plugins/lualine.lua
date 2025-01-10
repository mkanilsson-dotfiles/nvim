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
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },

                    lualine_x = { "encoding", "fileformat" },
                    lualine_y = { "filetype", "location" },
                    lualine_z = { "searchcount", "selectioncount" },
                }
            }
        end
    }
}
