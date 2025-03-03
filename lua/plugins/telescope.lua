--https://github.com/nvim-telescope/telescope.nvim
--https://github.com/nvim-telescope/telescope-fzf-native.nvim

return {
    'nvim-telescope/telescope.nvim',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        --to get fzf-native working,you need to build it with either cmake or make
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    event = 'VimEnter',

    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<c-c>"] = require('telescope.actions').close
                },
            },

            --change the title of the preview window dynamically
            dynamic_preview_title = true,

            --指定默认布局策略为'horizontal'
            layout_strategy = 'horizontal',
            --自定义布局,适配不同屏幕尺寸
            layout_config = {
                horizontal = {
                    preview_width = 0.6,
                    prompt_position = "top",
                },
                vertical = {
                    preview_height = 0.5,
                },
            },
            --自定义提示符
            prompt_prefix = "🔍",
            --搜索结果按升序显示
            sorting_strategy = "ascending",
            --避免过长的文件路径
            path_display = { "truncate" },
            --在搜索时忽略常见的大型文件夹(如node_modules)
            file_ignore_patterns = { "node_modules", "*.lock" },
        },

        pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                hidden = true,
            },
            live_grep = {
                --为live_grep picker添加自定义布局
                only_sort_text = true,
            },
        },

        extensions = {
            --使用fzf扩展,提升模糊搜索效率
            fzf = {
                fuzzy = true,
                --使用fzf排序
                override_generic_sorter = true,
                --替换文件排序
                override_file_sorter = true,
                --大小写智能匹配
                case_mode = "smart_case",
            },
        },
    },

    config = function(_, opts)
        --clone the default telescope configuration(default is rg)
        local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
        --to search in hidden/dot files
        table.insert(vimgrep_arguments, "--hidden")
        --do not search in '.git' directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")
        opts.defaults.vimgrep_arguments = vimgrep_arguments

        local telescope = require('telescope')
        telescope.setup(opts)
        telescope.load_extension('fzf')

        local builtin = require('telescope.builtin')
        --file pickers
        --lists files in current working directory, respects .gitignore
        vim.keymap.set('n', '<leader>o', builtin.find_files, { desc = "Telescope:find file" })

        --search for a string in current working directory and get results live as you type
        vim.keymap.set('n', '<leader>i', builtin.live_grep, { desc = "Telescope:find string" })

        --searches for the string under your cursor or selection in your current working directory
        vim.keymap.set('n', '<leader>fu', builtin.grep_string,
            { desc = "Telescope:find string under cursor or selection" })

        --vim pickers
        --list buffers
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope:list buffers" })

        --list marks
        vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = "Telescope:list marks" })

        --list registers,pastes the contents of the register on <cr>
        vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = "Telescope:list registers" })

        --list keymappings of normal mode
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Telescope:list keymappings of normal mode" })

        --lists vim options,allows you to edit the current value on <cr>
        vim.keymap.set('n', '<leader>fv', builtin.vim_options, { desc = "Telescope:list vim options" })

        --lists manpage entries
        vim.keymap.set('n', '<leader>fa', builtin.man_pages, { desc = "Telescope:list manpage entries" })

        --list jumplist(可以通过telescope来查看jump list，就可以把normal模式下的<c-o>和<c-i>重新映射另作他用
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Telescope:list jumplist" })

        --lists items in the quickfix list
        --vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = "Telescope:list items in the quickfix list" })

        --lists items from the current window's location list
        --vim.keymap.set('n', '<leader>fl', builtin.loclist, { desc = "Telescope:list items from the window's location list" })

        --lists available plugin/user commands and runs them on <cr>
        vim.keymap.set('n', '<leader>fx', builtin.commands, { desc = "Telescope:list plugin/user commands" })

        --lists vim autocommands and goes to their declaration on <cr>
        vim.keymap.set('n', '<leader>fy', builtin.autocommands, { desc = "Telescope:list autocommands" })

        --lists spelling suggestions for the current word under the cursor, replaces word with selected suggestion on <cr>
        vim.keymap.set('n', '<leader>fw', builtin.spell_suggest, { desc = "Telescope:spelling suggestions" })

        --lists all available filetypes and apply to current file on <cr>
        vim.keymap.set('n', '<leader>ft', builtin.filetypes, { desc = "Telescope:list available filetypes" })

        --lists built-in pickers and run them on <cr>
        vim.keymap.set('n', '<leader>fd', builtin.builtin,
            { desc = "Telescope:list built-in pickers and run them on <cr>" })

        --require('utils.notify').notify_with_timeout("插件:telescope 已加载", 3000)
    end
}

--telescope.nvim是neovim社区广泛使用的模糊搜索插件,基于lua编写,提供了强大的查找和搜索功能。其主要功能包括：
--1,文件查找:快速查找文件,尊重.gitignore,还可以自定义搜索工具如rg(ripgrep)。
--2,字符串搜索:在当前工作目录中搜索字符串,并根据输入实时更新结果。
--3,缓冲区和书签列表:列出所有缓冲区,书签和其他与neovim状态相关的内容,如注册表,跳转列表等。
--4,扩展支持:支持加载扩展,如fzf扩展,增强模糊搜索能力。

--suggested dependencies
--BurntSushi/ripgrep is required for live_grep and grep_string and is the first priority for find_files
--we also suggest you install one native telescope sorter to significantly improve sorting performance:telescope-fzf-native.nvim

--optional dependencies
--sharkdp/fd (finder)

--:help telescope
--:help telescope.setup(),see default configuration options
--:help telescope.builtin,see picker specific opts
--:help telescope.command
--:help telescope.layout
--:help telescope.resolve
--:lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})
--:checkhealth telescope

--?:show mappings for picker actions (normal mode)
--<c-/>:show mappings for picker actions (insert mode)
--<c-u>	scroll up in preview window
--<c-d>	scroll down in preview window
--<c-q> send all items to quickfix
--<M-q>	send all selected items to quickfix

--available keys:c,g,n,z
