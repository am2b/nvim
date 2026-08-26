--https://github.com/akinsho/bufferline.nvim

return {
    'akinsho/bufferline.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    event = { 'VeryLazy' },

    opts = {
        options = {
            --显示buffers而不是tabs
            mode = "buffers",
            --显示buffer ID
            numbers = "buffer_id",
            --如果安装了nvim-web-devicons,显示buffer图标
            show_buffer_icons = true,
            --显示tab指示器
            show_tab_indicators = true,
            --设置分隔符风格
            --separator_style = "slant",
            --在tab上显示错误(buffer名字变红)
            diagnostics = 'nvim_lsp',
        },
    },

    keys = {
        { '|', '<cmd>BufferLinePick<cr>',      desc = 'Pick buffer' },
        { '(', '<cmd>BufferLineCyclePrev<cr>', desc = 'Go to prev buffer' },
        { ')', '<cmd>BufferLineCycleNext<cr>', desc = 'Go to next buffer' },
    },
}
