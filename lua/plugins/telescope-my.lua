local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

--取缓冲区的绝对目录,缓冲区无效/无名字时返回nil
local function buffer_dir(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return nil
    end
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
        return nil
    end
    return vim.fn.fnamemodify(name, ":p:h")
end

--把用户输入解析成真正要传给命令的参数
--若输入是相对路径:优先按原缓冲区所在目录解析,其次按当前工作目录解析,
--命中的文件/目录存在就替换为绝对路径,否则原样返回(可能根本不是路径)
--input:用户输入
--orig_buf:打开picker时所在的缓冲区号
local function resolve_input(input, orig_buf)
    if input == "" then
        return input
    end

    --已经是绝对路径 / 家目录路径,直接使用
    if input:match("^[/~]") then
        return input
    end

    local candidates = {}

    --相对"原缓冲区所在目录"解析
    if vim.api.nvim_buf_is_valid(orig_buf) then
        local buf_name = vim.api.nvim_buf_get_name(orig_buf)
        if buf_name ~= "" then
            local buf_dir = vim.fn.fnamemodify(buf_name, ":p:h")
            candidates[#candidates + 1] = buf_dir .. "/" .. input
        end
    end

    --相对当前工作目录解析
    candidates[#candidates + 1] = vim.fn.getcwd() .. "/" .. input

    for _, candidate in ipairs(candidates) do
        if vim.fn.filereadable(candidate) == 1 or vim.fn.isdirectory(candidate) == 1 then
            return candidate
        end
    end

    return input
end

--实际执行命令
--执行时临时把当前缓冲区切回orig_buf,把工作目录切到orig_buf_dir,
--保证命令内部的expand('%'),getfperm(),相对路径都按正确上下文解析
--command:命令元数据(nvim_get_commands的返回值)
--input:用户输入(可能为空)
--orig_buf:打开picker时所在的缓冲区号
--orig_buf_dir:原缓冲区的绝对目录
local function run_command(command, input, orig_buf, orig_buf_dir)
    local args = nil

    if input and input ~= "" then
        input = resolve_input(input, orig_buf)
        if command.nargs == "1" or command.nargs == "?" then
            --单个参数:整个输入原样作为一个参数
            args = { input }
        else
            --"*" / "+" 等:按空白拆分为多个参数
            args = vim.split(input, "%s+", { trimempty = true })
        end
    end

    local cwd = vim.fn.getcwd()

    local execute = function()
        vim.api.nvim_cmd({ cmd = command.name, args = args }, {})
    end

    if vim.api.nvim_buf_is_valid(orig_buf) then
        --在原始缓冲区上下文里执行(expand('%'),% 等都基于它)
        vim.api.nvim_buf_call(orig_buf, function()
            --临时切到原缓冲区目录,执行完恢复
            if orig_buf_dir and orig_buf_dir ~= cwd then
                vim.fn.chdir(orig_buf_dir)
            end
            execute()
            if orig_buf_dir and orig_buf_dir ~= cwd then
                vim.fn.chdir(cwd)
            end
        end)
    else
        --原缓冲区已失效:直接按当前上下文执行
        execute()
    end
end

--打开命令选择器
--opts:可选配置:
-- prefix:命令名前缀过滤,默认"My"
-- prompt_title:提示标题,默认"My Commands"
function M.my_commands(opts)
    opts = opts or {}
    local prefix = opts.prefix or "My"

    --记住打开 picker 时的缓冲区与它的目录(此刻 cwd 正确,相对缓冲区名展开可靠)
    local orig_buf = vim.api.nvim_get_current_buf()
    local orig_buf_dir = buffer_dir(orig_buf)

    local commands = vim.api.nvim_get_commands({})
    local results = {}

    for name, command in pairs(commands) do
        if name:sub(1, #prefix) == prefix then
            table.insert(results, command)
        end
    end

    table.sort(results, function(a, b)
        return a.name < b.name
    end)

    pickers.new({}, {
        prompt_title = opts.prompt_title or "My Commands",

        finder = finders.new_table({
            results = results,

            entry_maker = function(command)
                local display = command.name

                if command.desc and command.desc ~= "" then
                    display = string.format(
                        "%-30s %s",
                        command.name,
                        command.desc
                    )
                end

                return {
                    value = command,
                    display = display,
                    --同时按名称和描述模糊匹配
                    ordinal = command.name .. " " .. (command.desc or ""),
                }
            end,
        }),

        sorter = conf.generic_sorter({}),

        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                if not entry then
                    return
                end

                local command = entry.value
                if not command then
                    return
                end

                actions.close(prompt_bufnr)

                --不需要参数的命令:直接执行
                if command.nargs == "0" then
                    local ok, err = pcall(function()
                        run_command(command, nil, orig_buf, orig_buf_dir)
                    end)

                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR, { title = command.name })
                    end
                    return
                end

                --需要参数的命令:先询问参数,再执行
                vim.ui.input({
                    prompt = command.name .. " ",
                }, function(input)
                    if input == nil then
                        return
                    end

                    local ok, err = pcall(function()
                        run_command(command, input, orig_buf, orig_buf_dir)
                    end)

                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR, { title = command.name })
                    end
                end)
            end)

            return true
        end,
    }):find()
end

return M
