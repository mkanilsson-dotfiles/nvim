return {
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {}
            require('telescope').load_extension('projects')

            vim.keymap.set("n", "<space>pp", require("telescope").extensions.projects.projects, {
                desc = "List projects"
            })
        end
    }
}
