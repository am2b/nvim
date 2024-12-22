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
            trig = ";rr",
            dscr = "\"${var}\"",
            snippetType = "autosnippet",
        },

        fmta(
            [[
            "${<>}"<>
        ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";re",
            dscr = "${var}",
            snippetType = "autosnippet",
        },

        fmta(
            [[
            ${<>}<>
        ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";ar",
            dscr = "${array[@]}",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                "${<>[@]}"<>
            ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";as",
            dscr = "${#array[@]",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                "${#<>[@]}"<>
            ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";hm",
            dscr = "$(date +%s%3N)",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                $(date +%s%3N)
                <>
            ]],

            { i(0) }
        )
    ),
}
