return {
    "am2b/keep.nvim",
    event = { 'VeryLazy' },
    keys = {
        { "<space>ls", "<cmd>lua require('keep').load_session()<cr>", desc = "Restore session" }
    },

    config = function()
        local user_opts = {
            ignore_dirs = {
                "%.git/",
                "%.venv/",
            }
        }

        require("keep").setup(user_opts)
    end,
}
