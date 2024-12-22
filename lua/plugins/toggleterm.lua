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
        --保持终端打开状态,这样终端关闭后就不会立即销毁。
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
        vim.keymap.set("t", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Toggleterm:Move cursor between windows" })
        vim.keymap.set("t", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Toggleterm:Move cursor between windows" })

        vim.keymap.set("t", "<esc>", "<cmd>ToggleTerm<cr>", { desc = "Toggleterm:Toggle terminal" })
    end
}
