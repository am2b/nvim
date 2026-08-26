--https://github.com/akinsho/toggleterm.nvim

return {
    'akinsho/toggleterm.nvim',

    keys = {
        { "<space><space>", "<cmd>ToggleTerm direction=float<cr>",            desc = "Toggleterm:Open float terminal window" },
        { "<space>jj",      "<cmd>ToggleTerm direction=horizontal<cr>",       desc = "Toggleterm:Open horizontal terminal window" },
        { "<space>ll",      "<cmd>ToggleTerm direction=vertical size=75<cr>", desc = "Toggleterm:Open vertical terminal window" },
    },

    opts = {
        start_in_insert = true,
        --在多个终端窗口之间切换时,记住每个终端所处的状态(insert/normal模式)
        persist_mode = true,
        --设定水平和垂直终端的默认大小
        --size = 20,
        --默认浮动终端
        direction = "float",
        float_opts = {
            --使用更美观的曲线边框
            border = "curved",
        },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)

        vim.keymap.set("t", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Toggleterm:Move cursor between windows" })
        vim.keymap.set("t", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Toggleterm:Move cursor between windows" })
        --在有的终端里,<c-h>和退格键<bs>是同一个控制字符(0x08),所以可能会导致退格失效(删不掉字符)
        vim.keymap.set("t", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Toggleterm:Move cursor between windows" })
        vim.keymap.set("t", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Toggleterm:Move cursor between windows" })

        vim.keymap.set("t", "<esc>", "<cmd>ToggleTerm<cr>", { desc = "Toggleterm:Toggle terminal" })
    end
}

--toggleterm的终端默认就是常驻的(:ToggleTerm关掉只是隐藏,不会销毁,除非真的退出shell)
