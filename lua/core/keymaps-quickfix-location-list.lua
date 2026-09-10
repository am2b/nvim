local keymap = vim.keymap

--quickfix list
--无需给:copen映射快捷键,因为quickfix list可以自动打开
--keymap.set("n", "<space>co", "<cmd>copen<cr>", { desc = "Normal:Open quickfix list" })
keymap.set("n", "<space>cc", "<cmd>cclose<cr>", { desc = "Normal:Close quickfix list" })

--location list
--keymap.set("n", "<space>lo", "<cmd>lopen<cr>", { desc = "Normal:Open location list" })
--keymap.set("n", "<space>lc", "<cmd>lclose<cr>", { desc = "Normal:Close location list" })
