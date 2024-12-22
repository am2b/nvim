--https://github.com/folke/persistence.nvim

return {
    'folke/persistence.nvim',

    keys = { { "<space>ls", function() require("persistence").load() end, desc = "restore neovim session" }, },

    config = function()
        require('persistence').setup {
            dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
            options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
            branch = true,
        }

        --load the session for the current directory
        vim.keymap.set("n", "<space>ls", function() require("persistence").load() end)

        --require('utils.notify').notify_with_timeout("插件:persistence 已加载", 3000)
    end
}
