--https://github.com/L3MON4D3/LuaSnip

return {
    'L3MON4D3/LuaSnip',
    --安装javascript正则表达式支持,增强匹配能力
    build = 'make install_jsregexp',

    event = { 'InsertEnter' },

    config = function()
        require("luasnip").setup({
            --允许在snippet中回退跳转
            history = true,
            --在snippet中修改文字时,使其保持活跃
            delete_check_events = "TextChanged",

            --enable automatic snippet expansion
            enable_autosnippets = true,

            --use tab to trigger visual selection
            --pressing <tab> in visual mode will then store the visually-selected text in a LuaSnip variable called LS_SELECT_RAW, which we will reference later to retrieve the visual selection.
            --定义snippet时用i(1, { restore_selection = true })
            --举例:
            --s("wrap", {
            --    t("console.log("),
            --    i(1, { restore_selection = true }),
            --    t(")")
            --})
            --先选中foo + bar,按<tab>,然后再输入wrap,就变成:console.log(foo + bar)
            store_selection_keys = "<tab>",

            --更新LuaSnip的监听事件,使其更加灵敏,用于动态snippet,比如有条件判断,递归嵌套片段,会在打字时动态刷新
            --TextChanged:普通模式改变
            --TextChangedI:插入模式下改变
            update_events = "TextChanged,TextChangedI",
        })

        --设置自定义代码片段存放路径为~/.config/nvim/snippets
        --:echo stdpath('config') -> ~/.config/nvim
        local default_path = vim.fn.stdpath('config') .. '/snippets'
        local passwords_path = default_path .. '/passwords'
        local loaders_lua = require("luasnip.loaders.from_lua")

        --从自定义路径加载lua格式的代码片段
        loaders_lua.lazy_load({
            paths = { default_path, passwords_path }
        })

        --c-f,c-d:jump to the next and previous placeholder
        vim.cmd [[imap <silent><expr> <c-f> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<c-f>']]
        vim.cmd [[smap <silent><expr> <c-f> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<c-f>']]
        vim.cmd [[imap <silent><expr> <c-d> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<c-d>']]
        vim.cmd [[smap <silent><expr> <c-d> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<c-d>']]
    end
}
