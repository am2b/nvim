local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";br",
            dscr = "<br>",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                <<br>>
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";lk",
            dscr = "file link",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                [<>](<>)
            ]],

            { i(1), rep(1) }
        )
    ),
}
