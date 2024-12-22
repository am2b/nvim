local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local conds_expand = require("luasnip.extras.conditions.expand")
local line_begin = conds_expand.line_begin

return {
    s(
        {
            --trig:the string or Lua pattern (i.e. Lua-flavored regex) used to trigger the snippet.
            trig = ";sb",
            dscr = "import sympy as sb",
            --regTrig:
            --whether the snippet trigger should be treated as a Lua regular expression. false by default.
            regTrig = false,
            --wordTrig:
            --a safety feature to prevent snippets from expanding when the snippet trigger is part of a larger word. true by default.
            --since the wordTrig safety feature can conflict with regular expression triggers, you often want to set wordTrig = false when using regTrig = true snippets.
            snippetType = "autosnippet",
            --lowered the snippet’s priority to 100 (the default is 1000)
            --priority = 100,
        },

        --text node
        { t("import sympy as sb") },
        --the condition key gives you a lot of power
        --especially if you leverage built-in Vim functions (e.g. line(), col(), nvim_get_current_line(), etc.) to get information about the current line and cursor position for use in the condition function.
        --LuaSnip even passes a few convenience variables to the condition function for you
        --see the opts section in :help luasnip-snippets for details.
        --note:can expand when there are spaces or tabs at the beginning of the line
        { condition = line_begin }
    ),

    s(
        {
            trig = ";np",
            dscr = "import numpy as np",
            snippetType = "autosnippet",
        },
        { t("import numpy as np") },
        { condition = line_begin }
    ),

    s(
        {
            trig = ";mpl",
            dscr = "import matplotlib as mpl",
            snippetType = "autosnippet",
        },
        { t("import matplotlib as mpl") },
        { condition = line_begin }
    ),

    s(
        {
            trig = ";plt",
            dscr = "import matplotlib.pyplot as plt",
            snippetType = "autosnippet",
        },
        { t("import matplotlib.pyplot as plt") },
        { condition = line_begin }
    ),
}
