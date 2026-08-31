return {
    "am2b/stardust.nvim",

    event = { 'VeryLazy' },

    config = function()
        --centered = true:n跳转后居中
        require("stardust").setup({ centered = true })
    end,
}
