local flash = require('flash')

--do not use :lua, since that will break dot-repeat
--也可以使用"/"
vim.keymap.set({ "n", "x", "o" }, "<leader>s", function() flash.jump() end,
    { desc = "Normal-Visual-Operator_pending:Search by flash" })

--也可以使用"/^"
vim.keymap.set({ "n" }, "<leader>;", function()
        flash.jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^"
        })
    end,
    { desc = "Normal:Jump to a line by flash" })

--在normal,visual,模式下,依据当前光标位置来对周围的tree-sitter结构进行标记,选择label后,被label包围的部分自动选中
--在operator_pending模式下,依据当前光标位置来对周围的tree-sitter结构进行标记,选择label后,被label包围的部分自动完成operator_pending的"母"动作
--这种情况下,也支持通过;和,来扩展和缩小选中的范围(标签)
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end,
    { desc = "Normal-Visual-Operator_pending:Pick treesitter node by flash" })

--[[
for example:
1,press yr to start yanking and open flash
2,enter the characters you are interested
3,select a label to set the cursor position
4,perform any motion,like iw or even start flash Treesitter with S(note:there is no need to repeat the button y again)
5,the yank will be performed(automatically by step 3) on the new selection
6,you'll be back in the original window / position(automatically)
7,press p to paste
--]]
vim.keymap.set({ "o" }, "r", function() flash.remote() end, { desc = "Operator_pending:Remotely operate by flash" })

--基于输入的字符,找到包含输入的字符的tree-sitter结构,然后对该tree-sitter结构进行层次化的不同粒度的标记
--选择好给出的label后:
--在visual模式下,自动将被label包围的部分选中
--在operator_pending模式下,被label包围的部分自动完成"母"动作
vim.keymap.set({ "x", "o" }, "R", function() flash.treesitter_search() end,
    { desc = "Visual-Operator_pending:Mark treesitter node by flash" })

--在operator_pending模式下,想要操作一个不规则的结构(无法通过tree-sitter node来标记的结构),这时可以通过"/"来搜索字符,然后按下对应的标签来定位出从当前光标到这个标签之间的部分

--[[
可以不占用<leader>w,而使用<leader>s或者"/"即可
vim.keymap.set({ "n", }, "<leader>w", function()
        flash.jump({
            search = {
                mode = function(str)
                    return "\\<" .. str
                end,
            },
        })
    end,
    { desc = "Normal:Match beginning of words only by flash" })
--]]
