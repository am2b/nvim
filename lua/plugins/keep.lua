return {
    "am2b/keep.nvim",
    event = { 'VeryLazy' },
    keys = {
        { "<space>ls", "<cmd>lua require('keep').load_session()<cr>", desc = "Restore session" }
    },

    config = function()
        require("keep").setup()
    end,
}
