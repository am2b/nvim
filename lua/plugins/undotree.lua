--https://github.com/mbbill/undotree

return {
    'mbbill/undotree',

    --启动时注册键位,等到第一次按键时才真正加载插件
    keys = {
        { '<space>ut', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' },
    },

    init = function()
        -- 打开面板时焦点进入树窗口
        vim.g.undotree_SetFocusWhenToggle = 1
        -- 布局1-4(默认1:diff面板在树下方,2:diff横贯底部)
        vim.g.undotree_WindowLayout = 2
        -- 时间标签缩短为"2 h"形式
        vim.g.undotree_ShortIndicators = 1
    end,
}

--q:关闭
-->num<:当前,{num}:下次redo,[num]:最新,s/S:保存,=num=:diff标记
--D:toggle diff窗口
