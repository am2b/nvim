return {
    "am2b/stardust.nvim",
    event = { 'VeryLazy' },

    config = function()
        require("stardust").setup()
    end,
}
