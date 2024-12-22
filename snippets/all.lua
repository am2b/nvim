local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local f = ls.function_node
local line_begin = conds_expand.line_begin

local helpers = require("plugins.luasnip_helper")

local get_selected = helpers.get_selected

return {
    s(
        {
            trig = ";;sd",
            dscr = "surround selected with single quotes",
            snippetType = "autosnippet",
        },
        fmta(
            [['<>']],
            {
                d(1, get_selected),
            }
        )
    ),

    s(
        {
            --can not be trigged at the very beginning of the line
            trig = "([^%a])tt",
            regTrig = true,
            wordTrig = false,
            snippetType = "autosnippet",
        },

        fmta(
            "<>^",
            {
                --function node:return first capture group
                f(function(_, snip) return snip.captures[1] end),
            }
        )
    ),
}
