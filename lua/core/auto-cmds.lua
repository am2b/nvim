local augroup_user = vim.api.nvim_create_augroup('user_auto_cmds', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = augroup_user,
    pattern = { 'help' },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = true, desc = "Use q to close the help window" })
    end
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

vim.api.nvim_create_autocmd('FileType', {
    group = augroup_user,
    pattern = { 'python' },
    callback = function()
        vim.keymap.set("n", "<localleader>c", "I#<esc>", { buffer = true, desc = "Comment a line" })
    end
})

--stop automatic newline continuation of comments
vim.api.nvim_create_autocmd('FileType', {
    group = augroup_user,
    pattern = { 'lua', 'python', 'perl', 'c', 'cpp', 'sh', 'awk', 'zsh', 'rust' },
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
