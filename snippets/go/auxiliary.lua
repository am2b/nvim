local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local conds_expand = require("luasnip.extras.conditions.expand")
local line_begin = conds_expand.line_begin
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";imp",
            dscr = "import",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                import (
                    "fmt"
                    "os"
                    "strings"
                    "bufio"
                    "log"
                )

                <>
            ]],

            { i(0) }
        ),

        { condition = line_begin }
    ),

    s(
        {
            trig = ";;",
            dscr = ":=",
            snippetType = "autosnippet",
        },
        fmta(
            [[
                := <>
            ]],

            { i(1) }
        )
    ),
}
