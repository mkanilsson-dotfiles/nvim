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
                    "Makefile",
                    "package.json",
                    "go.mod",
                    "Cargo.toml",
                    "*.opam",
                    "dune-project",
                    "*.sln",
                    ".mvim"
                },
            }
            require('telescope').load_extension('projects')
        end
    }
}
