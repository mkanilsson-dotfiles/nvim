return {
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                patterns = {
                    ".git",
                    "_darcs",
                    ".hg",
                    ".bzr",
                    ".svn",
                    ".mvim",
                },
                detection_methods = { "patterns" },
            }
            require('telescope').load_extension('projects')
        end
    }
}
