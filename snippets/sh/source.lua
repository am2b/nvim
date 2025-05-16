local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";sabs",
            dscr = "source script",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                SELF_ABS_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
                source "${SELF_ABS_DIR}"/<>

                <>
            ]],

            { i(1), i(0) }
        )
    ),
}
