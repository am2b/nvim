local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";isiz",
            dscr = "import QSize",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                from PySide6.QtCore import QSize
                <>
            ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";iapp",
            dscr = "import QApplication",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                from PySide6.QtWidgets import QApplication
                <>
            ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";iwid",
            dscr = "import QWidget",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                from PySide6.QtWidgets import QWidget
                <>
            ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";imai",
            dscr = "import QMainWindow",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                from PySide6.QtWidgets import QMainWindow
                <>
            ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";ipus",
            dscr = "import QPushButton",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                from PySide6.QtWidgets import QPushButton
                <>
            ]],

            { i(0) }
        )
    ),
}
