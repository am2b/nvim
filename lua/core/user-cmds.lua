--注意:命令的名字必须以大写字母开头

--highlighting the selection on yank
--replaced by plugin:yanky.nvim
--vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank {timeout=500,on_visual=false}]]

local nvim_config_path = vim.fn.stdpath("config")

--校验shell脚本是否可读,具备可执行权限
local function check_shell_script_valid(script_path)
    --判断文件是否存在且可读
    if not vim.fn.filereadable(script_path) then
        vim.notify(string.format("脚本不存在或不可读:%s", script_path), vim.log.levels.ERROR)
        return false
    end

    --判断文件是否拥有可执行权限
    --getfperm返回格式示例:rwxr-xr-x,最后一位是当前用户执行位
    local file_perm = vim.fn.getfperm(script_path)
    if file_perm:sub(3, 3) ~= "x" then
        vim.notify(
            string.format("脚本无执行权限,请执行:chmod +x %s", script_path),
            vim.log.levels.WARN
        )
        return false
    end

    return true
end

vim.api.nvim_create_user_command("MyReloadConfig", "source $MYVIMRC", { desc = "reload neovim configuration" })

vim.api.nvim_create_user_command('MyReplaceMarks', function()
    local file_name = vim.fn.expand('%')
    local script = nvim_config_path .. "/scripts/text_replace_chinese_punctuation_marks.sh"

    --防止未打开文件
    if file_name == "" then
        vim.notify("当前未打开任何文件", vim.log.levels.ERROR)
        return
    end

    if not check_shell_script_valid(script) then
        return
    end

    vim.cmd('w')
    --调用配置目录下的脚本绝对路径
    --vim.fn.shellescape():对脚本路径,文件路径做shell转义,防止路径包含空格,特殊符号时命令执行报错
    vim.cmd('!' .. vim.fn.shellescape(script) .. ' ' .. vim.fn.shellescape(file_name))
    --重新加载文件
    --vim.fn.fnameescape():对文件路径字符串进行vim路径安全转义,专门用于vim.cmd(),vim内置命令场景,避免路径包含空格,中文,括号,#,$,&等特殊字符时命令执行失败
    vim.cmd('e ' .. vim.fn.fnameescape(file_name))
    --vim.cmd('!text_replace_chinese_punctuation_marks.sh ' .. file_name)
    --重新加载文件
    --vim.cmd('e ' .. file_name)
end, { nargs = 0, desc = 'replace chinese punctuation marks' }
)

local function has_user_exec(file_name)
    local perm = vim.fn.getfperm(file_name)
    if perm == "" then
        vim.notify("无法访问文件: " .. file_name, vim.log.levels.ERROR)
        return nil
    end
    --"rwxr-xr-x":第3位是当前用户的可执行位
    return perm:sub(3, 3) == "x"
end

--vim.uv.fs_stat(file_name)
--vim.uv是neovim内置的LibUV接口,用于异步操作文件和系统功能
--fs_stat(file_name)返回一个表,包含目标文件的详细信息,如大小,模式,修改时间等,如果文件不存在或访问失败,返回nil
vim.api.nvim_create_user_command("MyAddX", function()
    local file_name = vim.fn.expand('%')
    if file_name == "" then
        print("no file to make executable")
        return
    end

    local exec = has_user_exec(file_name)
    if exec == nil then return end

    if not exec then
        vim.fn.system("chmod +x " .. vim.fn.shellescape(file_name))
        print("added execute permission to " .. file_name)
    else
        print(file_name .. " has execute permission")
    end
end, { nargs = 0, desc = 'add executable permission to current file' })

vim.api.nvim_create_user_command("MyRemoveX", function()
    local file_name = vim.fn.expand('%')
    if file_name == "" then
        print("no file to make executable")
        return
    end

    local exec = has_user_exec(file_name)
    if exec == nil then return end

    if exec then
        vim.fn.system("chmod -x " .. vim.fn.shellescape(file_name))
        print("removed execute permission from " .. file_name)
    else
        print(file_name .. " does not have execute permission")
    end
end, { nargs = 0, desc = 'remove executable permission from current file' })

vim.api.nvim_create_user_command("MyToggleX", function()
    local file_name = vim.fn.expand('%')
    if file_name == "" then
        print("no file to toggle execute permission")
        return
    end

    local exec = has_user_exec(file_name)
    if exec == nil then return end

    if not exec then
        vim.fn.system("chmod +x " .. vim.fn.shellescape(file_name))
        print("added execute permission to " .. file_name)
    else
        vim.fn.system("chmod -x " .. vim.fn.shellescape(file_name))
        print("removed execute permission from " .. file_name)
    end
end, { nargs = 0, desc = 'toggle executable permission of current file' })

vim.api.nvim_create_user_command('MyInsertDate', function()
    vim.api.nvim_put({ os.date("%Y-%m-%d") }, 'c', true, true)
end, { desc = 'insert date' })

vim.api.nvim_create_user_command('MyInsertDateTime', function()
    vim.api.nvim_put({ os.date("%Y-%m-%d %H:%M:%S") }, 'c', true, true)
end, { desc = 'insert date and time' })

vim.api.nvim_create_user_command('MyInsertPass', function(opts)
    local script = nvim_config_path .. "/scripts/generate_password.sh"

    if not check_shell_script_valid(script) then
        return
    end

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

--totp:
vim.api.nvim_create_user_command("MyTotp", function()
    local script = nvim_config_path .. "/scripts/totp.sh"

    if not check_shell_script_valid(script) then
        return
    end

    local line = vim.api.nvim_get_current_line()
    local trim_line = vim.trim(line)
    if trim_line == "" then
        vim.notify("当前行内容为空,无法执行TOTP生成", vim.log.levels.ERROR)
        return
    end

    local safe_line = vim.fn.shellescape(trim_line)
    local handle = io.popen(string.format("bash %s %s", vim.fn.shellescape(script), safe_line))
    if handle then
        local result = handle:read("*a")
        handle:close()
        result = vim.trim(result)
        if result == "" then
            vim.notify("TOTP脚本执行未返回有效结果", vim.log.levels.WARN)
            return
        end
        --复制到系统剪贴板
        vim.fn.setreg("+", result)
        vim.api.nvim_echo({ { "TOTP: " .. result .. " (copied)", "String" } }, false, {})
    else
        vim.notify("调用totp.sh脚本失败", vim.log.levels.ERROR)
    end
end, {})

--删除全部的缓冲区,但是除了当前缓冲区
vim.api.nvim_create_user_command("MyDeleteOtherBuffers", [[
    let cur = bufnr('%') | silent! execute 'bufdo if bufnr("%") != '.cur.' | bdelete! | endif'
]], {})

--删除全部的缓冲区
vim.api.nvim_create_user_command("MyDeleteAllBuffers", "bufdo bd", {})

--替换一行里面的中文标点符号
vim.api.nvim_create_user_command('MyFormatChineseCommentsLine', function()
    vim.cmd([[
        silent! s/\s\|。$//g
        silent! s/，/,/g
        silent! s/：/:/g
        silent! s/（/(/g
        silent! s/）/)/g
        silent! s/“/"/g
        silent! s/”/"/g
        silent! s/？/?/g
        let @/=''
    ]])
end, { desc = 'Format a line of chinese comments' })

--替换整个buffer里面的中文标点符号
vim.api.nvim_create_user_command('MyFormatChineseCommentsBuffer', function()
    vim.cmd([[
        silent! %s/\s\|。$//g
        silent! %s/，/,/g
        silent! %s/：/:/g
        silent! %s/（/(/g
        silent! %s/）/)/g
        silent! %s/“/"/g
        silent! %s/”/"/g
        silent! %s/？/?/g
        let @/=''
    ]])
end, { desc = 'Format a buffer of chinese comments' })

vim.api.nvim_create_user_command('MySortImports', function(opts)
    --获取当前文件的绝对路径
    local file_path = vim.fn.expand('%:p')
    if vim.bo.filetype == 'python' then
        local script = nvim_config_path .. '/scripts/python_sort_imports.sh'

        if not check_shell_script_valid(script) then
            return
        end

        --执行bash脚本,并传递当前python文件路径
        vim.fn.system('bash ' .. script .. ' ' .. vim.fn.shellscape(file_path))
        --刷新当前文件(重新加载buffer)
        vim.api.nvim_command('edit')
    end
end, {})
