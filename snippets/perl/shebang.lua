local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

--context-specific expansion
--write a Lua function that returns a boolean value: true when a snippet should expand and false when it should not.
local is_first_line = function()
    local line_number = vim.fn['line']('.')
    return line_number == 1
end

return {
    s(
        {
            trig = ";pl",
            dscr = "#!/usr/bin/env perl and common uses",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                #!/usr/bin/env perl

                use v5.38.0;
                use utf8::all;
                use warnings;

                <>
            ]],
            { i(0) }
        ),

        { condition = is_first_line }
    ),
}
