local keymap = vim.keymap

--previous command(c-p and c-n do not work)
keymap.set("c", "<c-k>", "<up>", { desc = "Command:Get the previous command" })
--next command
keymap.set("c", "<c-j>", "<down>", { desc = "Command:Get the next command" })
