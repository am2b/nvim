return {
    "am2b/smartnumber.nvim",
    event = { 'VeryLazy' },

    config = function()
        require("smartnumber").setup({ relative = true })
    end,
}
