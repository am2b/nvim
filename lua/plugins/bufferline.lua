--https://github.com/akinsho/bufferline.nvim

--:h bufferline-configuration

return {
    'akinsho/bufferline.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    event = { 'VeryLazy' },

    opts = {
        options = {
            --显示buffer ID
            numbers = "buffer_id",
            --显示活动buffer的指示器
            indicator = { icon = '▎', style = 'icon' },
            --如果安装了nvim-web-devicons,显示buffer图标
            show_buffer_icons = true,
            --显示tab指示器
            show_tab_indicators = true,
            --设置分隔符风格
            separator_style = "slant",
        },
    },

    config = function(_, opts)
        require('bufferline').setup(opts)

        vim.keymap.set("n", "|", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
        vim.keymap.set("n", "(", "<cmd>BufferLineCyclePrev<cr>", { desc = "Go to prev buffer" })
        vim.keymap.set("n", ")", "<cmd>BufferLineCycleNext<cr>", { desc = "Go to next buffer" })
    end
}
