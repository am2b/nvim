local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";si",
            dscr = "input operator",
            snippetType = "autosnippet",
        },

        fmt(
            [[
                <<>>
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";fh",
            dscr = "file handle",
            snippetType = "autosnippet",
        },

        fmt(
            [[
                <{}>
            ]],

            { i(1) },

            { delimiter = "{}" }
        )
    ),

    s(
        {
            trig = ";pb",
            dscr = "print a blank line",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                print("\n");
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";sh",
            dscr = "print hash",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                say map { "$_ =>> $<>{$_}\n" } keys %<>;
            ]],

            { i(1), rep(1) }
        )
    ),

    s(
        {
            trig = ";eu",
            dscr = "encoding(UTF-8)",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                encoding(UTF-8)
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";et",
            dscr = "expand_tilde()",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                expand_tilde("~/<>")
            ]],

            { i(1) }
        )
    ),

    s(
        {
            trig = ";st",
            dscr = "my $self = shift;",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                my $self = shift;
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";sf",
            dscr = "$self->",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                $self->>
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";;",
            dscr = "->",
            wordTrig = false,
            snippetType = "autosnippet",
        },

        fmta(
            [[
                ->>
            ]],

            {}
        )
    ),

    s(
        {
            trig = "; ",
            dscr = "=>",
            wordTrig = false,
            snippetType = "autosnippet",
        },

        fmta(
            [[
                =>>
            ]],

            {}
        )
    ),

    s(
        {
            trig = ";sa",
            dscr = "shift @ARGV",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                shift @ARGV;
            ]],

            {}
        )
    ),
}
