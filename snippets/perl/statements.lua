local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";if",
            dscr = "if statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if(<>)
                {
                    <>
                }
                <>
            ]],

            { i(1), i(2), i(0) }
        )
    ),

    s(
        {
            trig = ";es",
            dscr = "else statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                else
                {
                    <>
                }
                <>
            ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";ei",
            dscr = "elsif statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                elsif(<>)
                {
                    <>
                }
                <>
            ]],

            { i(1), i(2), i(0) }
        )
    ),

    s(
        {
            trig = ";ie",
            dscr = "if else statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if(<>)
                {
                    <>
                }
                else
                {
                    <>
                }
                <>
            ]],

            { i(1), i(2), i(3), i(0) }
        )
    ),

    s(
        {
            trig = ";ul",
            dscr = "unless statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                unless(<>)
                {
                    <>
                }
            ]],

            { i(1), i(2) }
        )
    ),

    s(
        {
            trig = ";wh",
            dscr = "while statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                while(<>)
                {
                    <>
                }
            ]],

            { i(1), i(2) }
        )
    ),

    s(
        {
            trig = ";ut",
            dscr = "until statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                until(<>)
                {
                    <>
                }
            ]],

            { i(1), i(2) }
        )
    ),

    s(
        {
            trig = ";fe",
            dscr = "foreach statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                foreach(<>)
                {
                    <>
                }
            ]],

            { i(1), i(2) }
        )
    ),

    s(
        {
            trig = ";fr",
            dscr = "for statement",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                for(<>; <>; <>)
                {
                    <>
                }
            ]],

            { i(1), i(2), i(3), i(4) }
        )
    ),
}
