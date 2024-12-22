local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local is_first_line = function()
    local line_number = vim.fn['line']('.')
    return line_number == 1
end

return {
    s(
        {
            trig = ";awk",
            dscr = "shebang",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                #!/usr/bin/env -S awk -f

                <>
            ]],

            { i(0) }
        ),

        { condition = is_first_line }
    ),
}
