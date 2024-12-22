--在离开insert mode时切换到英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        os.execute("im-select com.apple.keylayout.ABC")
    end,
})
