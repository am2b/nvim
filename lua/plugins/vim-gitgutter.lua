--https://github.com/airblade/vim-gitgutter

return {
    'airblade/vim-gitgutter',

    event = { 'BufNewFile', 'BufReadPost' },

    init = function()
        vim.g.gitgutter_sign_removed = "✖"

        --禁用所有默认按键绑定
        vim.g.gitgutter_map_keys = 0

        --禁止使用浮动窗口来预览
        vim.g.gitgutter_preview_win_floating = 0

        --不高亮变更的行(:GitGutterLineHighlightsToggle)
        vim.g.gitgutter_highlight_lines = 0
        --高亮变更行的行号
        vim.g.gitgutter_highlight_linenrs = 1

        --始终显示符号列,即使当前文件没有任何更改
        vim.g.gitgutter_sign_column_always = 1

        --do not suppress the signs when a file has more than 500 changes
        vim.g.gitgutter_max_signs = -1
    end,

    config = function()
        --查看更改(can take a preceding count)
        vim.keymap.set("n", "[c", "<Plug>(GitGutterNextHunk)", { silent = true, desc = "GitGutter:Next hunk" })
        vim.keymap.set("n", "]c", "<Plug>(GitGutterPrevHunk)", { silent = true, desc = "GitGutter:Previous hunk" })

        --暂存当前的更改
        vim.keymap.set("n", "<space>ha", ":GitGutterStageHunk<cr>", { silent = true, desc = "GitGutter:Stage hunk" })

        --撤销当前的更改
        vim.keymap.set("n", "<space>hr", ":GitGutterUndoHunk<cr>", { silent = true, desc = "GitGutter:Undo hunk" })
    end,
}

--:GitGutterStageBuffer:暂存当前buffer的所有更改
--:GitGutterUndoBuffer:撤销当前buffer的所有更改
--:GitGutterQuickFix:load all hunks into the quickfix list
