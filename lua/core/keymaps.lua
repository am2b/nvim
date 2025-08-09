--n:normal mode,
--i:insert mode
--x:visual mode
--c:command mode
--s:selection mode
--v:visual + selection
--t:terminal mode
--o:operator-pending
--!:insert + command
--'':normal + visual + selection + operator-pending

--vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--{opts} this must be a lua table.
--desc:a string that describes what the keybinding does.
--remap:a boolean that determines if our keybinding can be recursive.the default value is false.
--buffer:it can be a boolean or a number.if we assign the boolean true it means the keybinding will only be effective in the current file.if we assign a number, it needs to be the "id" of an open buffer.
--silent:a boolean,determines whether or not the keybindings can show a message.the default value is false.
--expr:a boolean.if enabled it gives the chance to use vimscript or lua to calculate the value of {rhs}.the default value is false.

local keymap = vim.keymap

--s as leader key, use cl for the original s
keymap.set({ "n", "x" }, "s", "<nop>")
--leader key
vim.g.mapleader = "s"

keymap.set({ "n", "x" }, ",", "<nop>")
--local leader key(用于在特定的filetype中做映射)
vim.g.maplocalleader = ","

--normal mode
--c-u, c-f:pageup and pagedown
keymap.set("n", "<c-u>", "<pageup>", { desc = "Normal:Page up" })

keymap.set("n", "<bs>", "<cmd>b#<cr>", { desc = "Normal:Switch between buffers" })

--resize window
keymap.set("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Normal:Resize up" })
keymap.set("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Normal:Resize down" })
keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "Normal:Resize left" })
keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "Normal:Resize right" })

--add space line
keymap.set("n", "<up>", "O<esc>j", { desc = "Normal:Add space line before the current line" })
keymap.set("n", "<down>", "o<esc>k", { desc = "Normal:Add space line after the current line" })

--break line
--gJ原本的行为:合并行,不添加空格(J:合并行并添加一个空格)
--keymap.set("n", "gJ", 'ylr<cr>i<c-r>"<esc>', { desc = "Normal:Break line" })
keymap.set("n", "gJ", "Do<esc>p", { desc = "Normal:Break line" })

--search with the 'very magic' mode
--keymap.set("n", "/", "/\\v", { desc = "Normal:Search with the very magic mode" })
--keymap.set("n", "?", "?\\v", { desc = "Normal:Search with the very magic mode" })

keymap.set("n", "n", "nzz", { desc = "Normal:Put cursor at center of window when search" })
keymap.set("n", "N", "Nzz", { desc = "Normal:Put cursor at center of window when search" })

--微调zz,<c-e>:将光标所在行向上移动一行,<c-y>:将光标所在行向下移动一行(光标跟着移动)
keymap.set("n", "zz", "zt5<c-y>", { desc = "Normal:Fine-tuning the zz command" })

--keybindings:
--vim.keymap.set can use a lua function as the action:
--vim.keymap.set('n', 'Q', function()
--    print('Hello')
--end, {desc = 'Say hello'})
--we can read these description if we use the command :map <keybinding>

--@:->repeat the last command in command mode
--c-g:view the infomation of current buffer
--gv:select the previous selected area in visual mode
--c-r c-w:put the word under cursor into command line in command mode

require("core.keymaps-insert")
require("core.keymaps-command")
require("core.keymaps-normal-leader")
require("core.keymaps-normal-space")
require("core.keymaps-visual-selection-leader")
require("core.keymaps-quickfix-location-list")
