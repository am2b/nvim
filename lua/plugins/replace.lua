return {
    'MagicDuck/grug-far.nvim',

    cmd = { 'GrugFar', 'GrugFarWithin' },
    keys = {
        { '<space>re', function() require('grug-far').open() end, desc = 'grug-far: 打开查找替换' },
        { '<space>rb', function() require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } }) end, desc = 'grug-far: 仅当前文件' },
        { '<space>ru', function() require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } }) end, desc = 'grug-far: 搜索光标下的词' },
    },

    config = function()
        require('grug-far').setup({
            engine = 'ripgrep',
            --防抖毫秒,打字快可调小
            debounceMs = 300,
            --最少输入多少字符才触发搜索
            minSearchChars = 2,
            --超过此数量停止搜索,防止卡顿
            maxSearchMatches = 2000,
            windowCreationCommand = 'vsplit',
            startInInsertMode = true,
            --结果区语法高亮
            resultsHighlight = true,
            folding = { enabled = true, foldlevel = 1 },
        })
    end,
}
