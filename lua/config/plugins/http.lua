return {
    {
        "rest-nvim/rest.nvim",
        config = function()
            -- @type rest.Opts
            vim.g.rest_nvim = {
                request = {
                    skip_ssl_verification = true,
                }
            }
        end
    }
}
