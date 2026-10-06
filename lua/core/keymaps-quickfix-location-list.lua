local keymap = vim.keymap

--quickfix list
keymap.set("n", "<space>co", "<cmd>copen<cr>", { desc = "Normal:Open the window of quickfix list" })
keymap.set("n", "<space>cc", "<cmd>cclose<cr>", { desc = "Normal:Close the window of quickfix list" })
