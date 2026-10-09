--https://github.com/akinsho/bufferline.nvim

return {
    'akinsho/bufferline.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    event = { 'VeryLazy' },

    opts = {
        options = {
            --显示buffer ID
            numbers = "buffer_id",
            --tab上buffer名字的颜色会等于诊断的颜色
            diagnostics = 'nvim_lsp',
        },
    },

    keys = {
        { '|', '<cmd>BufferLinePick<cr>',      desc = 'Pick buffer' },
        { '(', '<cmd>BufferLineCyclePrev<cr>', desc = 'Go to prev buffer' },
        { ')', '<cmd>BufferLineCycleNext<cr>', desc = 'Go to next buffer' },
    },
}

--依赖vim.opt.termguicolors = true
