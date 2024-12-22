local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";log",
            dscr = "init log",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if ! source $BASH_TOOLS_LOG_SH 2>>/dev/null; then
                    LOG_FUNCTIONS=("enable_log" "change_default_log_level" "log_debug" "log_info" "log_warn" "log_error")
                    for func in "${LOG_FUNCTIONS[@]}"; do
                        declare -f "${func}" >>/dev/null || eval "${func}() { :; }"
                    done
                else
                    enable_log "$0"
                fi
                <>
            ]],

            { i(0) }
        )
    ),
}
