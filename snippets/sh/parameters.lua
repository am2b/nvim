local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";para",
            dscr = "the number of parameters",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                check_parameters() {
                    if (("$#" <>)); then
                        usage
                    fi
                }

                <>
            ]],

            { i(1), i(0) }
        )
    ),
}
