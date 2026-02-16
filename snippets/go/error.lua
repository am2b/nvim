local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";err",
            dscr = "print err",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if err != nil {
                    fmt.Println(err)<>
                }

                <>
            ]],

            { i(1), i(0) }
        )
    ),
    s(
        {
            trig = ";we",
            dscr = "wrap error",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if err != nil {
                    return errorx.Wrap(<>, err)
                }

                <>
            ]],

            { i(1), i(0) }
        )
    ),
    s(
        {
            trig = ";ne",
            dscr = "new error",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if <> {
                    return errorx.New(<>)
                }

                <>
            ]],

            { i(1), i(2), i(0) }
        )
    ),
    s(
        {
            trig = ";re",
            dscr = "return error",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                if err != nil {
                    return err
                }

                <>
            ]],

            { i(0) }
        )
    ),
}
