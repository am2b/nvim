local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";opts",
            dscr = "getopts",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                process_opts() {
                    while getopts ":h" opt; do
                        case $opt in
                        h)
                            usage
                            ;;
                        *)
                            echo "error:unsupported option -$opt"
                            usage
                            ;;
                        esac
                    done
                }

                <>
        ]],

            { i(0) }
        )
    ),

    s(
        {
            trig = ";sopts",
            dscr = "shift options",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                shift $((OPTIND - 1))

                <>
            ]],

            { i(0) }
        )
    ),
}
