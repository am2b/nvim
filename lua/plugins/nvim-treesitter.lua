return {
    {
        'nvim-treesitter/nvim-treesitter',
        --新版不支持懒加载,必须关
        lazy = false,
        --更新插件时同步更新parser
        build = ':TSUpdate',
        config = function()
            --后台自动安装常用语言的parser
            require('nvim-treesitter').install {
                --元parser
                'lua', 'vim', 'vimdoc', 'query',
                'bash', 'python', 'go',
            }
            --新版高亮由neovim原生提供,需显式开启
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
