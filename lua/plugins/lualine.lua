--https://github.com/nvim-lualine/lualine.nvim

--winbar/statusline:
--+-------------------------------------------------+
--| A | B | C                             X | Y | Z |
--+-------------------------------------------------+

return {
    'nvim-lualine/lualine.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    event = { 'VeryLazy' },

    config = function()
        local utils = require("plugins.utils")

        local os_icon = ''
        if vim.fn.has("mac") then
            os_icon = ''
        end

        local opts = {
            options = {
                theme = 'powerline_dark',
                icons_enabled = true,
                component_separators = { left = '', right = '' },

                disabled_filetypes = {
                    statusline = { 'NvimTree', 'undotree', 'Outline' },
                    winbar = { 'help', 'NvimTree', 'Trouble', 'Outline', 'toggleterm' },
                },
            },

            sections = {
                lualine_a = {
                    { 'mode', fmt = function(str) return str:sub(1, 3) end }
                },

                lualine_b = {
                    {
                        'branch', color = { fg = '#00ff00', gui = 'bold' }, icon = { '', color = { fg = 'yellow' } },
                    },

                    { 'diff' },

                    {
                        'diagnostics',
                        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                    },
                },

                lualine_c = {
                    {
                        'filename',
                        symbols = {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed = '[No Name]',
                            newfile = '[New]',
                        },
                        color = { fg = '#00dd00' },
                    },
                },

                lualine_x = {
                    {
                        'searchcount',
                    },

                    {
                        'encoding',
                        fmt = utils.utf_8_format,
                        color = { fg = '#00dd00' },
                    },

                    {
                        'fileformat',
                        --use unix fileformat in mac:echo &fileformat -> unix
                        --如果显示的是'',那么究竟是什么换行符，最好通过echo &fileformat来确认
                        symbols = { unix = os_icon, },
                        color = { fg = '#00dddd' },
                    },

                    {
                        'filetype',
                        icons_enabled = false,
                        --icon_only = true,
                        fmt = utils.filetype_icon,
                        color = { fg = '#ffffff' },
                    },
                },

                lualine_z = {
                    { 'location' },

                    --lua function
                    { utils.user_name },
                },
            },

            inactive_sections = {
                lualine_c = {
                    {
                        'filename',
                        color = { fg = '#ffffff' },
                    },
                },
            },

            winbar = {
                lualine_y = {
                    {
                        'filename',
                        color = { fg = '#00dd00', bg = '#222222' },
                        --3:absolute path,with tilde as the home directory
                        path = 3,
                        --shortens path to leave 40 spaces in the window
                        shorting_target = 40,
                    },
                },
            },

            inactive_winbar = {
                lualine_y = {
                    {
                        'filename',
                        color = { fg = '#ffffff' },
                        --0:just the filename
                        path = 0,
                    },
                },
            },
        }

        require('lualine').setup(opts)
    end
}
