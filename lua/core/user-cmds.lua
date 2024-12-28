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

vim.api.nvim_create_user_command('MyInsertPass', function(opts)
    local nvim_config_path = vim.fn.stdpath("config")
    local script = nvim_config_path .. "/scripts/generate_password.sh"
    --当nargs为"?"时opts.args是可选参数,那么没有传递参数时opts.args的值默认为空字符串,而空字符串在lua里面被认为是true
    local len = opts.args ~= "" and opts.args or "64"
    local command = string.format("%s %s", script, len)
    --vim.fn.systemlist():执行外部命令并捕获输出
    --vim.fn.systemlist("command")返回一个表(数组),每个元素是一行命令输出,[1]表示从vim.fn.systemlist的返回值中获取第一行的内容
    local result = vim.fn.systemlist(command)
    local password = result[1]
    if vim.v.shell_error == 0 and password then
        vim.api.nvim_set_current_line(password)
    else
        print("failed to generate password")
    end
    --nargs = "?":表示命令接受可选参数
end, { nargs = "?", desc = 'insert password' })
--vim.fn.stdpath 支持以下参数:
--"config":返回用户的配置目录(通常为:~/.config/nvim)
--"data":返回用户的数据目录(通常为:~/.local/share/nvim)
--"cache":返回用户的缓存目录(通常为:~/.cache/nvim)
--"state":返回用户的状态目录(通常为:~/.local/state/nvim)
--"runtime":返回运行时文件的目录(包含config和data的子路径)
