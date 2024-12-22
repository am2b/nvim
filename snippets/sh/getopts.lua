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
                while getopts "h" opt; do
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
                shift $((OPTIND - 1))

                <>
        ]],

            { i(0) }
        )
    ),
}
