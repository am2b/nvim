local keymap = vim.keymap

--move cursor to the head and end of line
--keymap.set("n", "<leader>h", "^", { desc = "Normal:Move cursor to the first non-blank character of the line" })
--keymap.set("n", "<leader>l", "$", { desc = "Normal:Move cursor to the end of the line" })

--move the cursor to last edit position, like gi but do not enter insert mode
--`.:jump to the position of the last edit
--'.:jump to the line of the last edit
--`[:jump to start of previously yanked text
--`]:jump to end of previously yanked text
--`<:jump to the start of the last visual selection
--`>:jump to the end of the last visual selection
--'':jump to the position last jump
--_:move as ^
--|:move as 0
--c-o:go to older cursor position in jump list
--c-i:go to newer cursor position in jump list
--keymap.set("n", "<leader>n", "`.", { desc = "Normal:Move cursor to the last edit position" })

--upper inside word
keymap.set("n", "<leader>u", "gUiwe", { desc = "Normal:Upper inside word" })

--copy entire file
keymap.set("n", "<leader>yf", "<cmd>%y<cr>", { desc = "Normal:Copy entire file" })

--jump list

local log = require("utils.log")
local my_variable = "This is a test message."
log.log(my_variable)

-- 打印 table 示例
--local my_table = { name = "Alice", age = 25 }
--log.log(my_table)
