--注意:命令的名字必须以大写字母开头

--highlighting the selection on yank
--replaced by plugin:yanky.nvim
--vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank {timeout=500,on_visual=false}]]

vim.api.nvim_create_user_command("MyReloadConfig", "source $MYVIMRC", { desc = "reload neovim configuration" })

vim.api.nvim_create_user_command('MyReplaceMarks', function()
    local file_name = vim.fn.expand('%')
    vim.cmd('w')
    vim.cmd('!text_replace_chinese_punctuation_marks.sh ' .. file_name)
    --重新加载文件
    vim.cmd('e ' .. file_name)
end, { nargs = 0, desc = 'replace chinese punctuation marks' }
)

--vim.loop.fs_stat(file_name)
--vim.loop是neovim内置的LibUV接口,用于异步操作文件和系统功能
--fs_stat(file_name)返回一个表,包含目标文件的详细信息,如大小,模式,修改时间等,如果文件不存在或访问失败,返回nil

--bit.band(stat.mode, 0x40)
--使用位操作按位与(bit.band)提取stat.mode中的0x40位,判断文件是否具有用户可执行权限
--stat.mode是文件的权限模式,它是一个整数,表示文件的权限和类型
--0x40是一个位掩码,十六进制表示文件的"用户可执行"权限(S_IXUSR)

--bit.band(stat.mode, 0x40) ~= 0:文件具有用户可执行权限
--bit.band(stat.mode, 0x40) == 0:文件没有用户可执行权限
vim.api.nvim_create_user_command(
    "MyAddX",
    function()
        local file_name = vim.fn.expand('%')
        if file_name ~= "" then
            local stat = vim.loop.fs_stat(file_name)
            if not stat then
                print("failed to access file status")
            end
            if bit.band(stat.mode, 0x40) == 0 then
                vim.fn.system("chmod +x " .. file_name)
                print("added execute permission to " .. file_name)
            else
                print(file_name .. " has execute permission")
            end
        else
            print("no file to make executable")
        end
    end,
    { nargs = 0, desc = 'add executable permission to current file' }
)

vim.api.nvim_create_user_command(
    "MyRemoveX",
    function()
        local file_name = vim.fn.expand('%')
        if file_name ~= "" then
            local stat = vim.loop.fs_stat(file_name)
            if not stat then
                print("failed to access file status")
            end
            if bit.band(stat.mode, 0x40) ~= 0 then
                vim.fn.system("chmod -x " .. file_name)
                print("removed execute permission from " .. file_name)
            else
                print(file_name .. " does not have execute permission")
            end
        else
            print("no file to remove executable permission")
        end
    end,
    { nargs = 0, desc = 'remove executable permission from current file' }
)

vim.api.nvim_create_user_command(
    "MyToggleX",
    function()
        local file_name = vim.fn.expand('%')
        if file_name ~= "" then
            local stat = vim.loop.fs_stat(file_name)
            if stat and bit.band(stat.mode, 0x40) ~= 0 then
                vim.fn.system("chmod -x " .. file_name)
                print("removed execute permission from " .. file_name)
            else
                vim.fn.system("chmod +x " .. file_name)
                print("added execute permission to " .. file_name)
            end
        else
            print("no file to toggle executable permission")
        end
    end,
    { nargs = 0, desc = 'toggle executable permission of current file' }
)

vim.api.nvim_create_user_command('MyInsertDate', function()
    vim.api.nvim_put({ os.date("%Y-%m-%d") }, 'c', true, true)
end, { desc = 'insert date' })

vim.api.nvim_create_user_command('MyInsertDateTime', function()
    vim.api.nvim_put({ os.date("%Y-%m-%d %H:%M:%S") }, 'c', true, true)
end, { desc = 'insert date and time' })
