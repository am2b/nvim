local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";err",
            dscr = "print err",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if err != nil {
                    fmt.Println(err)<>
                }

                <>
            ]],

            { i(1), i(0) }
        )
    ),
}
