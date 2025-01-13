--https://github.com/neoclide/coc.nvim

return {
    'neoclide/coc.nvim',
    branch = 'release',

    event = { 'VimEnter' },

    config = function()
        vim.keymap.set('n', '<space>fm', '<Plug>(coc-format)', { silent = true, desc = "Normal:format by coc" })

        --显示悬停文档
        --在普通模式下,移动光标到函数或符号上,按K键,会看到一个悬浮窗口显示该符号的文档信息
        vim.api.nvim_set_keymap('n', 'K', ":call CocActionAsync('doHover')<cr>", { noremap = true, silent = true })

        --require('utils.notify').notify_with_timeout("插件:coc 已加载", 3000)
    end
}

--显示函数签名
--在插入模式下输入函数名,并在括号内时,按C键,会弹出参数提示窗口
--vim.api.nvim_set_keymap('i', 'C', 'coc#refresh()', { noremap = true, silent = true, expr = true })

--:CocRename:重命名变量
--:CocList extensions:查看扩展
--:CocUpdate:更新扩展
--:CocInfo:查看coc.nvim的状态
