local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";pl",
            dscr = "println!",
            snippetType = "autosnippet",
        },

        fmta(
            [[
            println!("<>");<>
        ]],

            { i(1), i(0) }
        )
    ),
}
