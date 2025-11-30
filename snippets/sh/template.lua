local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

--context-specific expansion
--write a Lua function that returns a boolean value: true when a snippet should expand and false when it should not.
local is_first_line = function()
    local line_number = vim.fn['line']('.')
    return line_number == 1
end

return {
    s(
        {
            trig = ";mysh",
            dscr = "the template code of bash script",
            snippetType = "autosnippet",
        },

        fmta(
            [[
#!/usr/bin/env bash

usage() {
    local script
    script=$(basename "$0")
    echo "usage:" >>&2
    echo "$script <>" >>&2
    exit "${1:-1}"
}

check_dependent_tools() {
    local missing=()
    for tool in "${@}"; do
        if ! command -v "${tool}" &>>/dev/null; then
            missing+=("$tool")
        fi
    done

    if ((${#missing[@]})); then
        echo "error:missing required tool(s):${missing[*]}" >>&2
        exit 1
    fi
}

check_envs() {
    if (("$#" == 0)); then
        return 0
    fi

    for var in "$@"; do
        #如果变量未导出或值为空
        if [ -z "$(printenv "$var" 2>> /dev/null)" ]; then
            echo "error:this script uses unexported environment variables:${var}"
            return 1
        fi
    done

    return 0
}

check_parameters() {
    if (("$#" <>)); then
        usage
    fi
}

process_opts() {
    while getopts ":h" opt; do
        case "$opt" in
        h)
            usage 0
            ;;
        *)
            echo "error:unsupported option -$opt" >>&2
            usage
            ;;
        esac
    done
}

main() {
    REQUIRED_TOOLS=(<>)
    check_dependent_tools "${REQUIRED_TOOLS[@]}"
    REQUIRED_ENVS=(<>)
    check_envs "${REQUIRED_ENVS[@]}" || exit 1
    process_opts "${@}"
    shift $((OPTIND - 1))<>
    check_parameters "${@}"
}

main "${@}"
        ]],
            { i(1), i(2), i(3), i(4), i(0) }
        ),

        { condition = is_first_line }
    ),
}
