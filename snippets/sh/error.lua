local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";ferr",
            dscr = "error message function",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                error_msg() {
                    printf "ERROR:\nSCRIPT:%s\nFUNC:%s\nLINE:%d\n" "$(basename "${0}")" "${FUNCNAME[1]}" "$1"
                }

                <>
            ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";perr",
            dscr = "print error message",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                error_msg "$LINENO"<>
            ]],

            { i(0) }
        )
    ),
}
