local sys = vim.loop.os_uname().sysname
local is_mac = sys == "Darwin"
local is_linux = sys == "Linux"

local english_input
local chinese_input

if is_mac then
    english_input = "com.apple.keylayout.ABC"
    chinese_input = "com.apple.inputmethod.SCIM.Shuangpin"
else
    english_input = "keyboard-us"
    chinese_input = "shuangpin"
end

--手动开关:
--打开:则进入插入模式和命令模式时自动切换到中文输入法
local manual_switch_for_chinese = false

vim.api.nvim_create_user_command("MyChineseEnable", function()
    manual_switch_for_chinese = true
    require('utils.notify').notify_with_timeout("开启:自动切换到中文", 3000)
end, {})

vim.api.nvim_create_user_command("MyChineseDisable", function()
    manual_switch_for_chinese = false
    require('utils.notify').notify_with_timeout("关闭:自动切换到中文", 3000)
end, {})

local function set_input_method(id)
    if is_mac then
        if vim.fn.executable("im-select") == 1 then
            --os.execute("im-select " .. id)
            vim.system({ "im-select", id })
        end
    elseif is_linux then
        if vim.fn.executable("fcitx5-remote") == 1 then
            vim.system({ "fcitx5-remote", "-s", id })
        end
    end
end

--进入insert mode模式时,如果打开了开关,则切换为中文输入法
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        if manual_switch_for_chinese then
            set_input_method(chinese_input)
        end
    end,
})

--进入命令模式时,如果打开了开关,则切换为中文输入法
vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = function()
        if manual_switch_for_chinese then
            set_input_method(chinese_input)
        end
    end,
})

--离开insert mode时,无条件的切换到英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        set_input_method(english_input)
    end,
})

--离开命令模式(:/?)时,无条件的切换到英文输入法
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        set_input_method(english_input)
    end,
})
