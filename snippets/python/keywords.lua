local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";tr",
            dscr = "expand to True",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                True
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";fa",
            dscr = "expand to False",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                False
            ]],

            {}
        )
    ),
}
