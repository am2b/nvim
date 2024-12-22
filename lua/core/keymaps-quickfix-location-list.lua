local keymap = vim.keymap

--quickfix list
keymap.set("n", "<space>co", "<cmd>copen<cr>", { desc = "Normal:Open quickfix list" })
keymap.set("n", "<space>cc", "<cmd>cclose<cr>", { desc = "Normal:Close quickfix list" })

--location list
keymap.set("n", "<space>lo", "<cmd>lopen<cr>", { desc = "Normal:Open location list" })
keymap.set("n", "<space>lc", "<cmd>lclose<cr>", { desc = "Normal:Close location list" })

--当打开quickfix窗口时,n和N用来模拟:cnext和:cprev
--判断quickfix是否打开且有内容的函数
local function is_quickfix_open()
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
    if is_quickfix_open() then
        return ":cnext<cr>"
    else
        return "n"
    end
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "N", function()
    if is_quickfix_open() then
        return ":cprev<cr>"
    else
        return "N"
    end
end, { expr = true, noremap = true, silent = true })
