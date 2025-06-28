local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";gnu",
            dscr = "check gnu tools",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                #GNU_TOOLS=(sed awk date)
                #check_gnu_tools "${GNU_TOOLS[@]}"
                check_gnu_tools() {
                    local missing=()
                    local not_gnu=()
                    for tool in "${@}"; do
                        local path

                        if ! path=$(command -v "$tool" 2>>/dev/null); then
                            missing+=("$tool")
                        else
                            if ! "$path" --version 2>>/dev/null | grep -qi "GNU"; then
                                not_gnu+=("$tool")
                            fi
                        fi
                    done

                    if ((${#missing[@]})); then
                        echo "error:missing required tool(s):${missing[*]}" >>&2
                        exit 1
                    fi
                    if ((${#not_gnu[@]})); then
                        echo "error:not GNU tool(s):${not_gnu[*]}" >>&2
                        exit 1
                    fi
                }
                <>
            ]],

            { i(0) }
        )
    ),
}
