--https://github.com/nvim-telescope/telescope.nvim
--https://github.com/nvim-telescope/telescope-fzf-native.nvim

--依赖的软件:ripgrep,fd

--?:show mappings for picker actions (normal mode)
--<c-/>:show mappings for picker actions (insert mode)
--<c-u>:scroll up in preview window
--<c-d>:scroll down in preview window
--<c-q>:send all items to quickfix
--<M-q>:send all selected items to quickfix

return {
    'nvim-telescope/telescope.nvim',

    dependencies = {
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
                    ["<c-c>"] = function()
                        require('telescope.actions').close()
                    end,
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
                --使用fzf排序(应该是已经默认恒真了)
                --override_generic_sorter = true,
                --替换文件排序(应该是已经默认恒真了)
                --override_file_sorter = true,
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

        --search symbols(当前buffer:类名,函数名,变量等)
        vim.keymap.set('n', '<leader>ff', builtin.lsp_document_symbols, { desc = 'Telescope:find document symbols' })
        --search symbols(整个项目:类名,函数名,变量等)
        --dynamic:自动用光标下的词作为初始搜索词(不用手动输入),并随打字实时刷新
        vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols,
            { desc = "Telescope:find workspace symbols" })

        require("plugins.telescope-cmds")(builtin)
    end
}
