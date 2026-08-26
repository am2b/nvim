local augroup_user = vim.api.nvim_create_augroup('user_auto_cmds', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = augroup_user,
    pattern = { 'help' },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = true, desc = "Use q to close the help window" })
    end
})

--让:grep自动打开quickfix窗口(省略掉:copen)
--事件QuickFixCmdPost:在:grep/:make/:vimgrep等以quickfix为结果容器的命令跑完后触发
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    --pattern = "[^l]*":匹配"不以l开头"的命令名,因为location list的命令(:lgrep,:lmake,:lwindow)都以l开头,而它们用的是location window不是quickfix,cwindow会开错窗口,所以要排除
    pattern = { "[^l]*" },
    callback = function()
        --只在有结果时才开(copen会强制开空窗口)
        --cwindow vs copen:copen无条件开空窗口,cwindow只在有结果时才开,正好配合<space>co手动开关
        vim.cmd("cwindow")
    end,
})

--强制设置统一的缩进样式
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
        vim.bo.expandtab = true
    end,
})

--自动保存
local auto_save_excluded_types = { lua = true }
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    group = augroup_user,
    pattern = "*",
    callback = function()
        if not auto_save_excluded_types[vim.bo.filetype] then
            vim.cmd("silent! wall")
        end
    end,
})

--vim.api.nvim_create_autocmd('FileType', {
--    group = augroup_user,
--    pattern = { 'python' },
--    callback = function()
--        vim.keymap.set("n", "<localleader>c", "I#<esc>", { buffer = true, desc = "Comment a line" })
--    end
--})

--stop automatic newline continuation of comments
vim.api.nvim_create_autocmd('FileType', {
    group = augroup_user,
    pattern = { 'lua', 'python', 'perl', 'c', 'cpp', 'sh', 'awk', 'zsh' },
    --pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o', })
    end
})

--stop highlighting after enter insert mode
local augroup_highlight = vim.api.nvim_create_augroup('user_highlight_cmds', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', {
    group = augroup_highlight,
    pattern = '*',
    callback = function()
        --vim.api.nvim_feedkeys用来模拟按键
        --vim.api.nvim_replace_termcodes用来处理按键字符串中的特殊字符
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cmd>noh<cr>', true, true, true), 'n', false)
    end
})

require("core.password-yank")
