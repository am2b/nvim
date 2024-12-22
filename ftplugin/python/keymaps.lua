vim.keymap.set('n', '<localleader><space>', '<cmd>!python %<cr>', { buffer = true, silent = true })

--vim.keymap.set('n','<leader>dn',function() require('dap-python').test_method() end)
--vim.keymap.set('n','<leader>df',function() require('dap-python').test_class() end)
--vim.keymap.set('v','<leader>ds',"<cmd><esc>require('dap-python').test_selection()<cr>")
