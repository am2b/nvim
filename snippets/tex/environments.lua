local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local tex_utils = {}
tex_utils.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()
    return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
tex_utils.in_equation = function()
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()
    return tex_utils.in_env('tikzpicture')
end
