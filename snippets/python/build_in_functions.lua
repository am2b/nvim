local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";pf",
            dscr = "print f-string",
            snippetType = "autosnippet",
        },
        fmta(
            'print(f"<> {<>}")',
            { i(1), i(2) }
        )
    ),

    s(
        {
            trig = ";pg",
            dscr = "print f-string with 2 {}",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                print(f"<> {<>} <> {<>}")
            ]],

            { i(1), i(2), i(3), i(4) }
        )
    ),

    s({ trig = ";pb", dscr = "print a blank line", snippetType = "autosnippet", },
        fmta(
            [[
                print()
                <>
            ]],
            { i(0) }
        )
    ),
}
