--https://github.com/mbbill/undotree

return {
    'mbbill/undotree',

    event = { 'VeryLazy' },

    config = function()
        vim.keymap.set('n', '<space>ut', vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end
}

--every change has a sequence number and it is displayed before timestamps
--the current state is marked as > number <
--the [ number ] marks the most recent change
--the next state which will be restored by :redo or <ctrl-r> is marked as { number }
--saved changes are marked as s and the big S indicates the most recent saved change
