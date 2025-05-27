--https://github.com/L3MON4D3/LuaSnip

return {
    'L3MON4D3/LuaSnip',
    --安装javascript正则表达式支持,增强匹配能力
    build = 'make install_jsregexp',

    event = { 'InsertEnter' },

    config = function()
        --设置自定义代码片段存放路径为~/.config/nvim/snippets
        --:echo stdpath('config') -> ~/.config/nvim
        local snippets_path = vim.fn.stdpath('config') .. '/snippets'
        --引入加载器:lua格式
        local loaders_lua = require("luasnip.loaders.from_lua")
        --引入加载器:vscode格式
        --local loaders_vs = require("luasnip.loaders.from_vscode")

        require("luasnip").setup({
            --enable automatic snippet expansion
            enable_autosnippets = true,

            --use tab to trigger visual selection
            --pressing <tab> in visual mode will then store the visually-selected text in a LuaSnip variable called LS_SELECT_RAW, which we will reference later to retrieve the visual selection.
            store_selection_keys = "<tab>",

            --for text in the repeated node to update as you type,the default update event is InsertLeave, which will update repeated nodes only after leaving insert mode.
            update_events = "TextChanged,TextChangedI",
        })

        --从自定义路径加载lua格式的代码片段
        loaders_lua.lazy_load({ paths = { snippets_path, } })
        --加载vscode风格的代码片段(通常来自friendly-snippets插件)
        --loaders_vs.lazy_load()

        --configure a command to edit the snippet files.
        --创建:LuaSnipEdit命令,用于快速编辑代码片段文件
        vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

        --c-o:展开代码片段,只有当有可展开片段时生效
        --use <c-o> to expand
        --imap and smap are intentionally used instead of inoremap and snoremap—this is standard (and necessary) practice when defining <Plug> mappings.
        --see :help luasnip-api-reference
        vim.cmd [[imap <silent><expr> <c-o> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<c-o>']]

        --c-f,c-d:jump to the next and previous placeholder
        vim.cmd [[imap <silent><expr> <c-f> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<c-f>']]
        vim.cmd [[smap <silent><expr> <c-f> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<c-f>']]
        vim.cmd [[imap <silent><expr> <c-d> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<c-d>']]
        vim.cmd [[smap <silent><expr> <c-d> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<c-d>']]

        --cycle forward through choice nodes with c-f
        --vim.cmd [[imap <silent><expr> <c-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-f>']]
        --vim.cmd [[smap <silent><expr> <c-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-f>']]
    end
}
