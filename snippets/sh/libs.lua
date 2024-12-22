local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";so",
            dscr = "source bash libs",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                #shellcheck source=/dev/null

                source "${HOME}/repos/bash-libs/include.sh"
                source "${PARAMETERS_SH}"
                source "${DIR_SH}"
                source "${FILE_SH}"
                source "${PATH_SH}"
                source "${STRING_SH}"
                source "${TEXT_SH}"
                source "${UTILS_SH}"
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";pn",
            dscr = "print usage if the number of parameters is wrong",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                print_usage_based_on_condition "$(expected_parameters_number $# <>)" "$<>"
            ]],

            { i(1, "number"), i(2, "usage") }
        )
    ),
}
