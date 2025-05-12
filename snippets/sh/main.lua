local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";main",
            dscr = "function main",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                main() {
                    check_parameters "${@}"
                    OPTIND=1
                    process_opts "${@}"
                    shift $((OPTIND - 1))

                    <>
                }

                main "${@}"
            ]],

            { i(0) }
        )
    ),
}
