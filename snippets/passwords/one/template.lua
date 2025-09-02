local ls = require("luasnip")
local f = ls.function_node
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local function uuidgen()
    --io.popen()是lua标准库提供的一个函数,用来执行shell命令并获取输出
    --它返回一个"文件句柄"(handle),可以从其中读取命令的输出(stdout)
    local handle = io.popen("uuidgen")
    --如果命令执行失败(比如uuidgen不存在),io.popen会返回nil
    if not handle then return "UUID_ERROR" end
    --handle:read("*a")表示读取所有输出内容(包括换行符):
    --*a = "all"
    local result = handle:read("*a")
    handle:close()
    --如果result存在,则执行result:gsub("%s*$",""):
    --:gsub("%s*$","")去掉尾部换行
    --如果result是nil,则返回"UUID_ERROR"
    return result and result:gsub("%s*$", "") or "UUID_ERROR"
end

return {
    s(
        {
            trig = ";one",
            dscr = "template:password:one",
            snippetType = "autosnippet",
            ft = "one",
        },

        fmta(
            [[
            UUID
            <uuid>

            标题
            <title>

            密码
            <password>

            标签
            <tags>
            ]],
            {
                uuid = f(function() return uuidgen() end),
                title = i(1),
                password = i(2),
                tags = i(3),
            }
        )
    ),
}
