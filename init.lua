--vim.loader.enable():是neovim内置的lua模块加速器,开启后,neovim会用原生加载器+字节码缓存来加载lua/下的模块,避免每次启动时重复解析lua源码,能明显加快启动速度,它必须放在所有require之前,否则对已加载的模块不生效
vim.loader.enable()

--neovim启动时只自动执行~/.config/nvim/init.lua这一个文件,其余所有.lua都不会被自动加载
--lua/目录很特殊:里面的文件可以通过require()按路径加载

--leader
--s as leader key, use cl for the original s
vim.g.mapleader = "s"
--local leader(用于在特定的filetype中做映射)
vim.g.maplocalleader = ","

--供插件读取基础设置
require("core.options")

--设置插件路径,允许用户自定义路径
--插件路径可配置,通过vim.g.lazy_path自定义插件路径
local lazy_path = vim.g.lazy_path or vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

--vim.fn.isdirectory替代vim.loop.fs_stat简化目录检查
if vim.fn.isdirectory(lazy_path) == 0 then
    vim.notify("正在安装lazy.nvim,请稍候...", vim.log.levels.INFO)
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazy_path,
    })

    if vim.v.shell_error ~= 0 then
        vim.fn.delete(lazy_path, 'rf')
        vim.notify("Lazy.nvim 安装失败,请检查网络", vim.log.levels.ERROR)
    end
end

vim.opt.rtp:prepend(lazy_path)

require('lazy').setup({
    --插件加载的顺序与priority(默认50)有关,与这里的顺序无关
    --{ import = 'plugins.xxx' }:lazy.nvim启动时会加载对应的文件:lua/plugins/xxx.lua
    --A clean,dark neovim theme written in Lua
    { import = 'plugins.tokyonight' },

    --A dependency library for many plugins
    { import = 'plugins.plenary' },

    --Provides Nerd Font icons for use by neovim plugins
    { import = 'plugins.icons' },

    --Seamless navigation between tmux panes and vim splits
    { import = 'plugins.tmux-navigator' },

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

    --Telescope's purpose is to provide an interface to filter a list of items
    { import = 'plugins.telescope' },

    { import = 'plugins.nvim-treesitter' },

    --nvim-lspconfig:用于简化语言服务器的配置
    { import = 'plugins.nvim-lspconfig' },

    --Snippet engine
    { import = 'plugins.luasnip' },

    --自动补全
    --会安装以下插件:
    --nvim-cmp
    --cmp-nvim-lsp
    --cmp-buffer
    --cmp-cmdline
    --cmp-path
    --cmp_luasnip
    { import = 'plugins.nvim-cmp' },

    --Improved yank and put functionalities
    { import = 'plugins.yanky' },

    --Lets you edit your filesystem like you edit text
    {
        --引入plugins/dirbuf.lua文件中的配置表作为插件的opts
        import = 'plugins.dirbuf',
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

    --Simple Neovim session manager
    { import = 'plugins.keep' },

    --Automatically toggles Neovim line numbers
    { import = 'plugins.smartnumber' },

    --Search Highlight Management
    { import = 'plugins.stardust' },
}, { install = { missing = true }, ui = { border = 'rounded' } })

require("core")
require("tools")
