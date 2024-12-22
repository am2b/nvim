vim.keymap.set('n', '<localleader><space>', '<cmd>!perl %<cr>', { buffer = true, silent = true })
--replace::with-> and then enter insert mode by A
vim.keymap.set('n', '<localleader>c', 'F:lc2h-><esc>A', { buffer = true, silent = true })
