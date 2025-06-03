return {
    "am2b/keep.nvim",
    --将lazy设置为true,表示默认不加载
    lazy = true,
    --通过keys和event触发加载
    --当按下<space>ls时,插件会被加载
    keys = {
        { "<space>ls", "<cmd>lua require('keep').load_session()<cr>", desc = "Restore session" }
    },
    --当neovim准备退出并触发VimLeavePre事件时,加载插件以执行保存操作
    event = "VimLeavePre",

    config = function()
        require("keep").setup()
    end,
}
