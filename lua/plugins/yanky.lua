--https://github.com/gbprod/yanky.nvim

--[[
这个插件的价值:
1,默认能够记录100条copy历史
2,在normal模式下,通过p或者P粘贴后,可以接着按<c-n>或者<c-p>来不断的更换刚才粘贴的内容
--]]

return {
    'gbprod/yanky.nvim',

    dependencies = { 'nvim-telescope/telescope.nvim' },

    event = { 'VeryLazy' },

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
