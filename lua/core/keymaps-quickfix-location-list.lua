local keymap = vim.keymap

--quickfix list
keymap.set("n", "<space>co", "<cmd>copen<cr>", { desc = "Normal:Open quickfix list" })
keymap.set("n", "<space>cc", "<cmd>cclose<cr>", { desc = "Normal:Close quickfix list" })

--location list
keymap.set("n", "<space>lo", "<cmd>lopen<cr>", { desc = "Normal:Open location list" })
keymap.set("n", "<space>lc", "<cmd>lclose<cr>", { desc = "Normal:Close location list" })

--n和N用来模拟:cnext和:cprev或者:lnext和lprev
--优先对Location List执行操作,否则操作Quickfix List

--检测当前窗口是否有Location List
local function is_locationlist_open()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.loclist == 1 then
            return true
        end
    end
    return false
end

--检查是否有Quickfix List
local function is_quickfixlist_open()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "filetype") == "qf" then
            return true
        end
    end
    return false
end

--动态调整n和N的行为
vim.keymap.set("n", "n", function()
    --仅当按下n或N时才会触发窗口遍历
    if is_locationlist_open() then
        return ":lnext<cr>"
    end

    if is_quickfixlist_open() then
        return ":cnext<cr>"
    end

    return "n"
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "N", function()
    if is_locationlist_open() then
        return ":lprev<cr>"
    end

    if is_quickfixlist_open() then
        return ":cprev<cr>"
    end

    return "N"
end, { expr = true, noremap = true, silent = true })
