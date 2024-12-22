local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";def",
            dscr = "define a function",
            snippetType = "autosnippet",
        },
        fmt(
            [[
                def <>(<>):
                    <>
            ]],

            { i(1, "name"), i(2, "params"), i(3, "pass") },

            { delimiters = "<>" }
        )
    ),

    s(
        {
            trig = ";ds",
            dscr = "docstrings",
            snippetType = "autosnippet",
        },
        fmta(
            [[
                """
                <>
                """
                <>
            ]],

            { i(1, "docstrings"), i(0) }
        )
    )
}
