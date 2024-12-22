--https://github.com/numToStr/Comment.nvim

return {
    'numToStr/Comment.nvim',

    event = { 'VeryLazy' },

    opts = {
        padding = false,
        --ignores empty lines
        ignore = '^$'
    },
}

--:h comment-nvim
--:h comment.config

--normal mode:
--line-comment:gcc
--block-comment:gbc - toggles the current line using blockwise comment

--operator-pending mode:
--line-comment:gc
--block-comment:gb
--gc[count]{motion}:toggles the region using linewise comment
--gb[count]{motion}:toggles the region using blockwise comment

--gco:insert comment to the next line and enters insert mode
--gcO:insert comment to the previous line and enters insert mode
--gcA:insert comment to end of the current line and enters insert mode

--gbaf:toggle comment around a function
--gbac:toggle comment around a class
