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

--normal mode:
--line-comment:gcc
--block-comment:gbc

--gco:insert comment to the next line and enters insert mode
--gcO:insert comment to the previous line and enters insert mode
--gcA:insert comment to end of the current line and enters insert mode

--operator-pending mode:
--line-comment:gc[count]{motion}
--block-comment:gb[count]{motion}

--af/ac需要文本对象:nvim-treesitter-textobjects
--gbaf:toggle comment around a function
--gbac:toggle comment around a class
