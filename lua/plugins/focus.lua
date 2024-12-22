--https://github.com/nvim-focus/focus.nvim

--:FocusEqualise:让窗口大小都相等
--:FocusMaximise:让窗口最大化
--要想恢复到"焦点窗口更大一些"的状态的话,需要退出neovim,然后再重新打开neovim

return {
    'nvim-focus/focus.nvim',

    keys = {
        { "<space>wh", "<cmd>lua require('focus').split_command('h')<cr>", desc = "Create split window or move to splited window (left)" },
        { "<space>wl", "<cmd>lua require('focus').split_command('l')<cr>", desc = "Create split window or move to splited window (right)" },
        { "<space>wk", "<cmd>lua require('focus').split_command('k')<cr>", desc = "Create split window or move to splited window (up)" },
        { "<space>wj", "<cmd>lua require('focus').split_command('j')<cr>", desc = "Create split window or move to splited window (down)" },
    },

    opts = {
        --enable/disable focus,default:true
        enable = true,
        --enable/disable focus commands,default:true
        commands = true,

        autoresize = {
            --enable/disable focus window autoresizing
            --if set false,the focussed window will no longer automatically resize,but other focus features are still available
            --default:true
            enable = true,
            --force width for the focused window.default:0:calculated based on golden ratio
            width = 0,
            height = 0,
            --force minimum width for the unfocused window.default:0:calculated based on golden ratio
            minwidth = 0,
            minheight = 0,
            --set the height of quickfix panel,:copen <height>
            height_quickfix = 10,
        },

        split = {
            --when creating a new split window, do/don't initialise it as an empty buffer
            --true:initialise it as a new blank buffer
            --false:retain a copy of the current window in the new window
            --default:false
            bufnew = false,
            --true:create tmux splits instead of neovim splits
            --false:create neovim split windows
            --default:false
            tmux = false,
        },
    },

    config = function()
        local focusmap = function(direction)
            vim.keymap.set('n', '<space>w' .. direction, function()
                require('focus').split_command(direction)
            end, { desc = string.format('Normal:Create or move to split (%s)', direction) })
        end

        focusmap('h')
        focusmap('j')
        focusmap('k')
        focusmap('l')

        local augroup = vim.api.nvim_create_augroup('focus_disable', { clear = true })

        local ignore_filetypes = { 'NvimTree', 'undotree', 'Outline' }
        vim.api.nvim_create_autocmd('FileType', {
            group = augroup,
            callback = function(_)
                if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                    vim.b.focus_disable = true
                else
                    vim.b.focus_disable = false
                end
            end,
            desc = 'disable focus autoresize for filetype',
        })

        --require('utils.notify').notify_with_timeout("插件:focus 已加载", 3000)
    end,
}
