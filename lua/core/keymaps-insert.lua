local keymap = vim.keymap

keymap.set({ "i" }, "<cr>", "<esc>o", { desc = "Insert:Easy to undo by line" })

--在下拉补全菜单中移动光标和选中
vim.cmd [[
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
]]
