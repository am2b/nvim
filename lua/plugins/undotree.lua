--https://github.com/mbbill/undotree

return {
    'mbbill/undotree',

    --启动时注册键位,等到第一次按键时才真正加载插件
    keys = {
        { '<space>ut', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' },
    },
}

--every change has a sequence number and it is displayed before timestamps
--the current state is marked as > number <
--the [ number ] marks the most recent change
--the next state which will be restored by :redo or <ctrl-r> is marked as { number }
--saved changes are marked as s and the big S indicates the most recent saved change
