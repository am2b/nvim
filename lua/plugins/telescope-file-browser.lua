--https://github.com/nvim-telescope/telescope-file-browser.nvim

return {
    'nvim-telescope/telescope-file-browser.nvim',

    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

    keys = {
        { "<leader>fe", '<cmd>Telescope file_browser<cr>',                               desc = "Telescope:open file browser" },
        { "<leader>fp", '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', desc = "Telescope:open file browser with the path of the current buffer" },
        { "<leader>jj", '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', desc = "Telescope:open file browser with the path of the current buffer" },
    },

    config = function()
        require('telescope').load_extension('file_browser')

        --open file_browser
        vim.keymap.set('n', '<leader>fe', '<cmd>Telescope file_browser<cr>', { desc = "Telescope:open file browser" })
        --open file_browser with the path of the current buffer
        vim.keymap.set('n', '<leader>fp', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
            { desc = "Telescope:open file browser with the path of the current buffer" })
        vim.keymap.set('n', '<leader>jj', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
            { desc = "Telescope:open file browser with the path of the current buffer" })

        --require('utils.notify').notify_with_timeout("插件:telescope-file-browser 已加载", 3000)
    end
}

--usage:
--<a-c>/c:create:create file/folder at current path (trailing path separator creates folder)
--<a-r>/r:rename:rename (multi-)selected files/folders
--<a-m>/m:move:move (multi-)selected files/folders to current path
--<a-y>/y:copy:copy (multi-)selected files/folders to current path
--<a-d>/d:delete:delete (multi-)selected files/folders
--<c-g>/g:goto_parent_dir:go to parent directory
--<c-e>/e:goto_home_dir:go to home directory
--<c-w>/w:goto_cwd:go to current working directory
--<c-f>/f:toggle_browser:toggle between file and folder browser
--<c-h>/h:toggle hidden files/folders
--<tab>:toggle selection and move to next selection
--<s-tab>:toggle selection and move to prev selection
--<c-s>/s:toggle all entries ignoring ./ and ../
--<bs>/:backspace:goes to parent dir
