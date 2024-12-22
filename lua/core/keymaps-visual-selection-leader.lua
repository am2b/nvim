local keymap = vim.keymap

--surround
keymap.set("v", "<leader>rd", "c''<esc>Pe", { desc = "Visual:Surround selected with single quotes" })
keymap.set("v", "<leader>rs", 'c""<esc>Pe', { desc = "Visual:Surround selected with double quotes" })
keymap.set("v", "<leader>rx", "c()<esc>Pe", { desc = "Visual:Surround selected with parentheses" })
keymap.set("v", "<leader>rz", "c[]<esc>Pe", { desc = "Visual:Surround selected with square bracket" })
keymap.set("v", "<leader>rh", "c{}<esc>Pe", { desc = "Visual:Surround selected with curly braces" })

--hold selected after indent
keymap.set("v", "<", "<gv", { desc = "Visual:Indent left" })
keymap.set("v", ">", ">gv", { desc = "Visual:Indent right" })

--move lines
keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Visual:Move lines down" })
keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Visual:Move lines up" })
