local M = {}

local log_file_path = vim.fn.expand("/tmp/nvim_debug.log")

M.log = function(msg)
    local file = io.open(log_file_path, "a")
    if file then
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")

        local log_message = ""
        if type(msg) == "string" then
            log_message = string.format("[%s] %s\n", timestamp, msg)
        elseif type(msg) == "table" then
            log_message = string.format("[%s] %s\n", timestamp, vim.inspect(msg))
        end

        file:write(log_message)
        file:close()
    else
        vim.notify("Failed to open log file: " .. log_file_path, vim.log.levels.ERROR)
    end
end

return M
