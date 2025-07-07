local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
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
        )
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
