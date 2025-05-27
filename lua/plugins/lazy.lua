--https://github.com/folke/lazy.nvim

--~/.local/share/nvim/lazy

local lazy = {}

--安装函数，使用vim.fn.isdirectory简化路径检查
function lazy.install(path)
    --vim.fn.isdirectory替代vim.loop.fs_stat简化目录检查
    if vim.fn.isdirectory(path) == 0 then
        --vim.fn.jobstart实现异步插件安装，避免阻塞neovim
        vim.fn.jobstart({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable',
            path,
        }, {
            on_exit = function() print("Lazy.nvim installed!") end,
        })
    end
end

--配置和初始化函数
function lazy.setup(plugins, opts)
    lazy.install(lazy.path)
    vim.opt.rtp:prepend(lazy.path)
    opts = vim.tbl_deep_extend('force', {
        install = { missing = true },
        ui = { border = 'rounded' },
    }, opts or {})
    require('lazy').setup(plugins, opts)
end

--设置插件路径，允许用户自定义路径
--插件路径可配置，通过vim.g.lazy_path自定义插件路径
lazy.path = vim.g.lazy_path or vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
--初始化默认配置
--提供默认配置，允许用户传入opts自定义配置
lazy.opts = {}

lazy.setup({
    --A clean,dark neovim theme written in Lua,with support for lsp,treesitter and lots of plugins
    { 'folke/tokyonight.nvim' },

    --A dependency library for many plugins
    { 'nvim-lua/plenary.nvim',            lazy = true },

    --Provides Nerd Font icons for use by neovim plugins
    { 'nvim-tree/nvim-web-devicons',      lazy = true },

    --Seamless navigation between tmux panes and vim splits
    { 'christoomey/vim-tmux-navigator' },

    --A snazzy bufferline for neovim
    { import = 'plugins.bufferline' },

    --A blazing fast and easy to configure neovim statusline plugin
    { import = 'plugins.lualine' },

    --Indent guides
    { import = 'plugins.indent-blankline' },

    --Smart and powerful comment plugin
    { import = 'plugins.comment' },

    --The undo history visualizer
    { import = 'plugins.undotree' },

    --Character motions
    { import = 'plugins.flash' },

    --Shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks
    { import = 'plugins.vim-gitgutter' },

    --To persist and toggle multiple terminals during an editing session
    { import = 'plugins.toggleterm' },

    --Navigate between marked files
    { import = 'plugins.harpoon' },

    --Configurations and abstraction layer for neovim
    { import = 'plugins.nvim-treesitter' },

    --Telescope's purpose is to provide an interface to filter a list of items
    { import = 'plugins.telescope' },

    --Session management
    { import = 'plugins.persistence' },

    --Snippet engine
    { import = 'plugins.luasnip' },

    --Debug Adapter Protocol client implementation for neovim
    { import = 'plugins.dap-adapters' },

    --UI for nvim-dap
    { import = 'plugins.dap-ui' },

    --Displays the values of variables and the evaluation results of expressions
    { import = 'plugins.dap-virtual-text' },

    --A full suite of window management enhancements
    { import = 'plugins.focus' },

    --Improved yank and put functionalities
    { import = 'plugins.yanky' },

    --Lets you edit your filesystem like you edit text
    {
        --引入plugins/dirbuf.lua文件中的配置表作为插件的opts
        import = 'plugins.dirbuf',
    },

    --Automatically toggle between relative and absolute line numbers
    {
        'sitiom/nvim-numbertoggle',
        event = { 'BufNewFile', 'BufReadPost' },
    },

    --Auto remove search highlight and rehighlight when using n or N
    {
        'nvimdev/hlsearch.nvim',
        --这个事件标志着neovim的启动工作已经基本完成,并且所有其他需要更早加载的插件(比如与编辑器核心功能直接相关的)已经加载完毕
        event = { 'BufNewFile', 'BufReadPost' },
        opts = {},
    },

    --Hightlights ranges you have entered in commandline
    {
        'winston0410/range-highlight.nvim',
        event = 'CmdlineEnter',
        --a command-line parser for plugin:winston0410/range-highlight.nvim
        dependencies = { 'winston0410/cmd-parser.nvim' },
        --自动调用require('range-highlight').setup()
        opts = {},
    },
}, lazy.opts)
