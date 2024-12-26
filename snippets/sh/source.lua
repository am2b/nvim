local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";sabs",
            dscr = "get my absolute path for source",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                SELF_ABS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
                source "${SELF_ABS_DIR}"/<>

                <>
            ]],

            { i(1), i(0) }
        )
    ),
}
