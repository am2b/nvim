local home = vim.env.HOME

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = home .. "/repos/socks/passwords/one/*",
    callback = function()
        --自定义一个filetype:one
        vim.bo.filetype = "one"
    end,
})
