--https://github.com/L3MON4D3/LuaSnip

--:echo stdpath('config') -> ~/.config/nvim

return {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',

    event = { 'InsertEnter' },

    config = function()
        local snippets_path = vim.fn.stdpath('config') .. '/snippets'
        local loaders_lua = require("luasnip.loaders.from_lua")
        local loaders_vs = require("luasnip.loaders.from_vscode")

        require("luasnip").setup({
            --enable automatic snippet expansion
            enable_autosnippets = true,

            --use tab to trigger visual selection
            --pressing <tab> in visual mode will then store the visually-selected text in a LuaSnip variable called LS_SELECT_RAW, which we will reference later to retrieve the visual selection.
            store_selection_keys = "<tab>",

            --for text in the repeated node to update as you type,the default update event is InsertLeave, which will update repeated nodes only after leaving insert mode.
            update_events = "TextChanged,TextChangedI",
        })

        loaders_lua.lazy_load({ paths = { snippets_path, } })
        --lazy_load() function will load any snippet we have in our runtimepath(friendly-snippets)
        loaders_vs.lazy_load()

        --configure a command to edit the snippet files.
        vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

        --use <c-o> to expand
        --imap and smap are intentionally used instead of inoremap and snoremap—this is standard (and necessary) practice when defining <Plug> mappings.
        --see :help luasnip-api-reference
        vim.cmd [[imap <silent><expr> <c-o> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<c-o>']]

        --jump to the next and previous placeholder
        vim.cmd [[imap <silent><expr> <c-f> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<c-f>']]
        vim.cmd [[smap <silent><expr> <c-f> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<c-f>']]
        vim.cmd [[imap <silent><expr> <c-d> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<c-d>']]
        vim.cmd [[smap <silent><expr> <c-d> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<c-d>']]

        --cycle forward through choice nodes with c-f
        --vim.cmd [[imap <silent><expr> <c-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-f>']]
        --vim.cmd [[smap <silent><expr> <c-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-f>']]
    end
}
