local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";doc",
            dscr = "documentclass",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \documentclass[<>, <>]{<>}
                <>
            ]],

            { i(1, "12pt"), i(2, "a4paper"), i(3, "article"), i(0) }
        )
    ),

    s(
        {
            trig = ";pac",
            dscr = "usepackage",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \usepackage{<>}
                <>
            ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";yah",
            dscr = "setmainfont",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \usepackage{fontspec}
                \setmainfont{Microsoft YaHei}
                <>
            ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";tad",
            dscr = "title author and date",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \title{<>}
                \author{<>}
                \date{\today}
                <>
            ]],

            { i(1), i(2), i(0) }
        )
    ),

    s(
        {
            trig = ";bod",
            dscr = "body part",
            snippetType = "autosnippet"
        },

        fmta(
            [[
                \begin{<>}
                <>
                \end{<>}
            ]],

            { i(1, "document"), i(2), rep(1) }
        )
    ),

    s(
        {
            trig = ";udl",
            dscr = "underline",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \underline{<>}
                <>
            ]],

            { i(1), i(0) }
        )
    ),

    s(
        {
            trig = ";fig",
            dscr = "figure",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \begin{<>}
                    \centering
                    \includegraphics[scale=<>]{<>}
                    \caption{<>}
                    \label{fig:<>}
                \end{<>}
                <>
            ]],

            { i(1, "figure"), i(2, "1.0"), i(3, "figure_filename"), i(4), rep(3), rep(1), i(0) }
        )
    ),

    s(
        {
            trig = ";itm",
            dscr = "list",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                \begin{<>}
                    \item <>
                    \item <>
                \end{<>}
            ]],

            { i(1), i(2), i(3), rep(1) }
        )
    ),
}
