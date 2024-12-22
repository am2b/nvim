--显示通知并在指定时间后清除
local M = {}

M.notify_with_timeout = function(msg, timeout)
    vim.notify(msg, vim.log.levels.INFO, { timeout = timeout })
    vim.defer_fn(function()
        --清空通知
        vim.notify('', vim.log.levels.INFO, { timeout = 0 })
    end, timeout)
end

return M
