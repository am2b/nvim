--https://github.com/airblade/vim-gitgutter

return {
    'airblade/vim-gitgutter',

    event = { 'BufNewFile', 'BufReadPost' },

    init = function()
        --删除行的符号
        vim.g.gitgutter_sign_removed = "✖"

        --禁用所有默认按键绑定
        vim.g.gitgutter_map_keys = 0

        --不用浮动窗口预览hunk
        vim.g.gitgutter_preview_win_floating = 0

        --高亮变更行的行号
        vim.g.gitgutter_highlight_linenrs = 1
    end,

    config = function()
        --默认4秒才刷新
        vim.opt.updatetime = 100
        --无更改也显示符号列:yes
        vim.opt.signcolumn = "yes"

        --查看上/下一个更改(can take a preceding count)
        vim.keymap.set("n", "[c", "<Plug>(GitGutterPrevHunk)", { silent = true, desc = "GitGutter:Previous hunk" })
        vim.keymap.set("n", "]c", "<Plug>(GitGutterNextHunk)", { silent = true, desc = "GitGutter:Next hunk" })

        --暂存当前的更改
        vim.keymap.set("n", "<space>ha", ":GitGutterStageHunk<cr>", { silent = true, desc = "GitGutter:Stage hunk" })

        --撤销当前的更改
        vim.keymap.set("n", "<space>hr", ":GitGutterUndoHunk<cr>", { silent = true, desc = "GitGutter:Undo hunk" })

        --在底部窗口查看当前hunk的diff
        vim.keymap.set("n", "<space>hp", ":GitGutterPreviewHunk<cr>", { silent = true, desc = "GitGutter:Preview hunk" })

        --ic:当前hunk的全部行,ac:当前hunk加上尾部空行
        vim.keymap.set("o", "ic", "<Plug>(GitGutterTextObjectInnerPending)", { silent = true })
        vim.keymap.set("o", "ac", "<Plug>(GitGutterTextObjectOuterPending)", { silent = true })
        vim.keymap.set("x", "ic", "<Plug>(GitGutterTextObjectInnerVisual)", { silent = true })
        vim.keymap.set("x", "ac", "<Plug>(GitGutterTextObjectOuterVisual)", { silent = true })
    end,
}

--:GitGutterToggle:开关
