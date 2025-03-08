local M = {}

local log_file_path = vim.fn.expand("/tmp/nvim_debug.log")

M.log_string = function(msg_string)
    local file = io.open(log_file_path, "a")
    if file then
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        local log_message = string.format("[%s] %s\n", timestamp, msg_string)
        file:write(log_message)
        file:close()
    else
        vim.notify("Failed to open log file: " .. log_file_path, vim.log.levels.ERROR)
    end
end

M.log_table = function(msg_table)
    local file = io.open(log_file_path, "a")
    if file then
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        local log_message = string.format("[%s] %s\n", timestamp, vim.inspect(msg_table))
        file:write(log_message)
        file:close()
    else
        vim.notify("Failed to open log file: " .. log_file_path, vim.log.levels.ERROR)
    end
end

return M
