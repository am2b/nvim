local keymap = vim.keymap

--delete all buffers except the current buffer
--the %bdelete command deletes all buffers.
--the % represents from 1 up to the highest value.
--the # in this context represents the alternate filename.
--the alternate file is the last buffer you were viewing before they all closed.
keymap.set("n", "<space>bd", "<cmd>%bdelete! | edit # | normal `.<cr>",
    { desc = "Normal:Delete all buffers except the current buffer" })

--delete current buffer
keymap.set("n", "<space>dd", "<cmd>bdelete<cr>",
    { desc = "Normal:Delete current buffer" })

--delete all buffers
keymap.set("n", "<space>da", "<cmd>bufdo bd<cr>",
    { desc = "Normal:Delete all buffers" })

--reload lua snippets
keymap.set("n", "<space>rs",
    "<cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/snippets/'})<cr>",
    { desc = "Normal:reload lua snippets" })

--replace the word under cursor
vim.keymap.set('n', '<space>su', function()
    --获取光标下的单词
    --expand()是一个vim函数,用于扩展特定标识符
    --<cword>表示光标所在的单词
    local word = vim.fn.expand('<cword>')
    local cmd = ':%s/\\<' .. word .. '\\>//g'
    --vim.api.nvim_replace_termcodes:将替换命令字符串cmd和光标移动操作<Left><Left>转换为neovim可以识别的输入序列
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd .. '<Left><Left>', true, false, true), 'n', false)
end, { noremap = true, silent = true, desc = "substitute the word under the cursor globally" })

--vim.api.nvim_replace_termcodes的参数:
--第1个参数:需要被转义的字符串,例如cmd .. '<Left><Left>'
--<Left>是vim的特殊按键表示符,用来将光标向左移动
--拼接后字符串为: :%s/\<word_under_cursor\>//g<Left><Left>
--第2个参数(from_part):true,表示要解析类似<Left>的特殊按键符号
--第3个参数(do_lt):false,表示不需要处理<lt>转义符
--第4个参数(special):true,表示允许解析特殊按键符号
--结果:返回一个已转义的字符串,neovim能识别其中的<Left>为"光标左移”操作

--vim.api.nvim_feedkeys(...)
--作用:模拟用户输入,将输入序列(按键命令)"喂"给neovim
--参数解释:
--第1个参数:转义后的字符串,比如 :%s/\<word_under_cursor\>//g<Left><Left>,其中<Left>已被正确解析为光标左移
--第2个参数(mode):传入'n',表示这些按键在普通模式下执行
--第3个参数(escape_ks):传入false,表示不进一步转义按键字符串

--format a line of chinese comment
vim.keymap.set('n', '<space>nl',
    --execute:在lua中用于动态执行字符串形式的vim命令
    --silent!:执行命令时不会在命令行中显示任何信息或错误,!表示即使替换失败也不会报错
    --\s:匹配空白字符,包括空格和制表符
    --\|:逻辑"或"(OR)
    --let@/=''
    --作用:清空搜索寄存器,避免高亮
    --@/:vim的搜索寄存器,用于存储最近一次的搜索或替换模式
    --silent!:用于在vim命令中静默执行命令并忽略错误
    --silent=true:用于在lua调用中静默执行函数
    --删除空白字符和行末尾的句号
    --替换逗号,冒号,小括号,双引号,问号
    [[:execute 'silent! s/\s\|。$//g | silent! s/，/,/g | silent! s/：/:/g | silent! s/（/(/g | silent! s/）/)/g | silent! s/“/"/g | silent! s/”/"/g | silent! s/？/?/g' | let @/='' <cr>]],
    {
        noremap = true,
        silent = true,
        desc = 'format a line of chinese comment'
    })

--模拟ctrl + z来挂起nvim
keymap.set("n", "<space>ff", "<c-z>", { desc = "Normal:ctrl + z" })
