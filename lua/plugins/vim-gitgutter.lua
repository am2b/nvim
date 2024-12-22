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

        --预览更改
        vim.keymap.set("n", "<space>hp", ":GitGutterPreviewHunk<cr>", { silent = true, desc = "GitGutter:Preview hunk" })
    end,
}

--:GitGutterStageBuffer:暂存当前buffer的所有更改
--:GitGutterUndoBuffer:撤销当前buffer的所有更改

--:GitGutterQuickFix:load all hunks into the quickfix list

--:GitGutterDiffOrig:open a vimdiff view of the current buffer

--:GitGutterFold:fold/unfold all unchanged lines,leaving just the hunks visible,use zr to unfold 3 lines of context above and below a hunk

--to stage part of any hunk:
--preview the hunk,<space>hp
--move to the preview window,:wincmd P(用于切换到预览窗口的命令)(:wincmd 是一个窗口管理命令的通用入口,P:表示切换到"预览窗口")
--delete the lines you do not want to stage
--stage the remaining lines:w

--中途放弃:
--1,如果打开了预览窗口,但还没有切换到预览窗口(即未执行 :wincmd P):
--可以直接关闭预览窗口:pclose

--2,如果已经切换到了预览窗口(即执行了:wincmd P):
--a,直接关闭预览窗口:在预览窗口中运行以下命令:q
--b,如果不想关闭预览窗口,而只是回到之前的窗口,可以使用:wincmd W

--3,如果你已经在预览窗口中编辑了内容,但又想放弃这些更改,可以使用以下方法:
--恢复预览内容:在预览窗口中运行:e!,或直接:q!关闭预览窗口
