local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";fd",
            dscr = "find dirs or files",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                excluded=(".git" ".DS_Store")
                conditions=()
                for item in "${excluded[@]}"; do
                    conditions+=(--exclude "${item}")
                done

                fd --hidden "${conditions[@]}" --type d/f "" "${dest_dir}"
                <>
            ]],

            { i(0) }
        )
    ),
}
