--https://github.com/folke/tokyonight.nvim

return {
    {
        'folke/tokyonight.nvim',
        --主题需要在启动时加载
        lazy = false,
        --保证第一个被加载
        priority = 1000,

        opts = {
            --主题风格
            style = 'night',
            --lualine中的粗体文字
            lualine_bold = true,
            --设置为false,保持不透明背景
            transparent = false,
            --在使用内置终端时保持主题一致性
            terminal_colors = true,
        },

        config = function(_, opts)
            --先setup,再应用配色
            require('tokyonight').setup(opts)
            vim.cmd.colorscheme('tokyonight')
        end,
    },
}
