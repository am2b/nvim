--https://github.com/akinsho/toggleterm.nvim

return {
    'akinsho/toggleterm.nvim',

    --当在command mode下输入这些命令的时候,让Lazy先加载插件
    cmd = { "TermFloat", "TermRight", "TermBottom" },

    opts = {
        float_opts = { border = "curved", },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)

        --float
        vim.api.nvim_create_user_command("TermFloat", "ToggleTerm direction=float", {})
        --右边
        vim.api.nvim_create_user_command("TermRight", "ToggleTerm direction=vertical size=75", {})
        --底部
        vim.api.nvim_create_user_command("TermBottom", "ToggleTerm direction=horizontal", {})

        --方便跳转
        vim.keymap.set("t", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Toggleterm:Move cursor between windows" })
        vim.keymap.set("t", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Toggleterm:Move cursor between windows" })
        --在有的终端里,<c-h>和退格键<bs>是同一个控制字符(0x08),所以可能会导致退格失效(删不掉字符)
        vim.keymap.set("t", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Toggleterm:Move cursor between windows" })
        vim.keymap.set("t", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Toggleterm:Move cursor between windows" })
    end
}

--打开终端的命令:
--:ToggleTerm direction=float
--:ToggleTerm direction=horizontal
--:ToggleTerm direction=vertical size=75

--关闭终端:
--a,exit
--b,<c-d>

--隐藏终端(下次再显示出来的时候处于normal mode):按下<c-\><c-n>让终端进入normal mode
--a,:q
--b,:ToggleTerm
--c,如果是float窗口的话,让其失去焦点也可以达到隐藏的目的
