local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";fpl",
            dscr = "Println",
            snippetType = "autosnippet",
        },
        fmta(
            [[
                fmt.Println(<>)<>
            ]],

            { i(1), i(0) }
        )
    ),
}
