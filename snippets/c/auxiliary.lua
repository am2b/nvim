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
            trig = ";;",
            dscr = "->",
            wordTrig = false,
            snippetType = "autosnippet",
        },

        fmta(
            [[
                ->>
            ]],

            {}
        )
    ),
}
