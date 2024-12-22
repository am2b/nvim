local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";snip",
            dscr = "framework of snippets",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                s(
                    {
                        trig = "<>",
                        dscr = "<>",
                        snippetType = "autosnippet",
                    },

                    fmta(
                        <>
                            <>
                        <>

                        {<>}
                    )
                ),
            ]],
            { i(1), i(2), i(3, "[["), i(4), i(5, "]],"), i(6) }
        )
    ),
}
