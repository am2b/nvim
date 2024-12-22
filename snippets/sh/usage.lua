local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";usage",
            dscr = "create usage function",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                usage() {
                    local script
                    script=$(basename "$0")
                    echo "usage:"
                    echo "$script <>"
                    exit 0
                }

                <>
            ]],

            { i(1), i(0) }
        )
    ),
}
