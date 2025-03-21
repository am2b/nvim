local group = vim.api.nvim_create_augroup('auto_cmds_gpg', { clear = true })

local gpg_workspace = vim.fn.expand("~") .. "/.keyring/.workspace/*"

--定义一个函数,在~/.keyring/.workspace目录下去掉yy复制时的换行符
local function yank_without_n()
    --获取当前行内容(不包含换行符)
    local line = vim.fn.getline(".")
    --填充默认寄存器
    vim.fn.setreg('"', line)
    --填充系统剪贴板寄存器
    vim.fn.setreg('+', line)

    require('utils.notify').notify_with_timeout("call yank_without_n", 3000)
end

--当进入~/.keyring/.workspace目录下的文件时,修改yy行为
vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = gpg_workspace,
    callback = function()
        --注意:这里是buffer级别的映射
        vim.keymap.set("n", "yy", yank_without_n, { noremap = true, silent = true, buffer = true })
    end
})

--当离开~/.keyring/.workspace目录的文件时,恢复默认yy行为
vim.api.nvim_create_autocmd("BufLeave", {
    group = group,
    pattern = gpg_workspace,
    callback = function()
        --取消buffer级别的映射,恢复默认yy
        vim.cmd("nunmap <buffer> yy")
    end
})
