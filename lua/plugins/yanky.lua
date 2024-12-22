--https://github.com/gbprod/yanky.nvim

--[[
这个插件的价值:
1,默认能够记录100条copy历史
2,在normal模式下,通过p或者P粘贴后,可以接着按<c-n>或者<c-p>来不断的更换刚才粘贴的内容
3,可以通过telescope来查看已经记录的copy历史条目,然后选中一个条目来粘贴:
3a,在telescope的normal模式下:<cr>和p都是粘贴到光标后面,P是粘贴到光标前面,d是删除条目,r是把条目复制进默认寄存器里面
3b,在telescope的insert模式下:<c-p>是粘贴到光标后面,<c-k>是粘贴到光标前面,<c-x>是删除条目,<c-r>是把条目复制进默认寄存器里面
--]]

return {
    'gbprod/yanky.nvim',

    dependencies = { 'nvim-telescope/telescope.nvim' },

    event = { 'BufNewFile', 'BufReadPost' },

    --插件加载后执行的配置代码
    config = function()
        require("yanky").setup()

        --将vim.keymap.set放在config函数内部,是为了确保键映射在插件加载后才生效
        --the cursor position will not change after performing a yank
        --x:operator-pending mode
        vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

        --this plugin contains no default mappings
        --with these mappings, after performing a paste, you can cycle through the history by hitting <c-n> and <c-p>
        vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
        vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

        require("telescope").load_extension("yank_history")
        vim.keymap.set('n', '<leader>yy', '<cmd>Telescope yank_history<cr>', { desc = "Telescope:open yank history" })
    end,
}

--you can clear yank history using :YankyClearHistory command

--if you execute :wshada in the first instance and then :rshada in the second instance, the second instance will be synced with the yank history in the first instance.
--sqlite is more reliable than ShaDa but requires more dependencies:kkharji/sqlite.lua
