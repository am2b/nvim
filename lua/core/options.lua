--:help option-list will show the options list in neovim
--inspect the value using :lua =,like :lua = vim.opt.some_option

--with 'vim' we have access to the editor's settings
--just like in vimscript, in lua we have different scopes for each option. We have global settings, window settings, buffer settings and a few others. Each one has its own namespace inside the vim module.
--vim.o:
--gets or sets general settings
--vim.wo:
--gets or sets window-scoped options
--vim.bo:
--gets or sets buffer-scoped options
--vim.g:
--gets or sets global variables
--this is usually the namespace where you'll find variables set by plugins
--the only one I know isn't tied to a plugin is the leader key
--vim.env
--gets or sets environment variables
--as far as I know if you make a change in an environment variables the change will only apply in the active neovim session.

--:verbose set formatoptions - to see who set the options

--disable netrw
--set the following at the very beginning of init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

--with vim.opt we can set global, window and buffer settings
local set = vim.opt

--what about global variables or the environment variables?
--for those you should keep using vim.g and vim.env respectively

set.fileencoding = "utf-8"

--line number
set.number = true

--用于控制触发自动命令,CursorHold等事件的时间,also controls the delay before vim writes its swap file
set.updatetime = 200

--highlight cursor line
set.cursorline = true
--set.cursorcolumn = true

--indent
--查看缩进相关设置的值:set tabstop? shiftwidth? softtabstop? expandtab?
--查看谁修改了相关的设置:verbose set tabstop?
--the amount of space on screen a tab character can occupy
set.tabstop = 4
--the amount of characters to indent a line.
set.shiftwidth = 4
set.softtabstop = 4
--controls whether or not transform a tab character to spaces
set.expandtab = true

set.autoindent = true

--fold
set.foldenable = true
--设置折叠方法为表达式
set.foldmethod = "expr"
--每一行都会根据表达式的结果来确定是否折叠
--这里使用的是treesitter提供的表达式函数
--v:lua.<lua_function>是neovim的lua调用方式,允许在vimscript配置中调用lua函数
--vim.treesitter.foldexpr()是nvim-treesitter提供的一个函数,用于根据treesitter的语法树生成折叠规则
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--折叠指示列,宽度为1
--"-":表示可以折叠
--"+":表示可以展开
set.foldcolumn = "1"
--在打开文件时,将展开深度小于或等于99的所有折叠块,这里表示"展开所有的折叠块"
set.foldlevel = 99
--限制折叠嵌套的最大深度
set.foldnestmax = 5

--enable persistent undo
set.undofile = true
--指定一个特定的撤销文件目录，以避免杂乱
set.undodir = os.getenv("HOME") .. "/.nvim/undodir"
set.swapfile = false

--use the clipboard for all operations
set.clipboard:append("unnamedplus")

--the position of new window
set.splitright = true
set.splitbelow = true

--search
set.ignorecase = true
set.smartcase = true
--display search hit BOTTOM or TOP
set.shortmess:append("S")

--appearance
--neovim 0.10.0 will now automatically determine if the terminal emulator supports 24 bit color (“truecolor”) and enable the 'termguicolors' option if it does
--enable 24-bit RGB color in the TUI
set.termguicolors = true

--always draw the sign column
set.signcolumn = "yes"

--give this job to statusline
set.showmode = false

--指定:grep命令背后实际调用的外部工具
--:grep可以通过外部程序搜索,:vimgrep只能通过vim内部搜索(:vimgrep速度慢)
-- --vimgrep:没这个参数,vim无法正确解析结果并放进quickfix
--让输出格式符合vim期望的quickfix格式:file:line:column:match
--可以排除掉多个目录,比如:--glob '!**/node_modules/**'
--使用方法:
--:grep pattern
--<enter>
--(这一步已经可以自动实现了):copen,"打开quickfix
--(j):cnext,"下一个匹配
--(k):cprev,"上一个匹配
--或通过grep-operator.vim:
--normal mode:
--<leader>giw:使用grep搜索一个word
--visual mode:
--<leader>g:使用grep搜索被选中的内容
set.grepprg = "rg --vimgrep --follow --smart-case --hidden --glob '!**/.git/**'"

--让:grep自动打开quickfix窗口(省略掉:copen)
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = { "[^l]*" },
    callback = function()
        --只在有结果时才开(copen会强制开空窗口)
        vim.cmd("cwindow")
    end,
})

--如果经常处理大文件的话，增加以下2个设置以提高性能
set.lazyredraw = true
set.synmaxcol = 200

--vim.opt can handle different types of data:
--lists:
--for some options neovim expects a comma separated list.
--in this case we could provide it as a string ourselves:
--vim.opt.wildignore = '*/cache/*,*/tmp/*'
--or we could use a table:
--vim.opt.wildignore = {'*/cache/*', '*/tmp/*'}

--sometimes we don't need to override the list, sometimes we need to add an item or maybe delete it.
--to makes things easier vim.opt offers support for the following operations:
--add an item to the end of the list:
--let's take errorformat as an example. If we want to add to this list using vimscript we do this:
--set errorformat+=%f\|%l\ col\ %c\|%m
--in lua we have a couple of ways to achieve the same goal:
--using the + operator:
--vim.opt.errorformat = vim.opt.errorformat + '%f|%l col %c|%m'
--or the :append method:
--vim.opt.errorformat:append('%f|%l col %c|%m')

--add to the beginning:
--in vimscript:
--set errorformat^=%f\|%l\ col\ %c\|%m
--lua:
--vim.opt.errorformat = vim.opt.errorformat ^ '%f|%l col %c|%m'
--or try the equivalent:
--vim.opt.errorformat:prepend('%f|%l col %c|%m')

--delete an item:
--vimscript:
--set errorformat-=%f\|%l\ col\ %c\|%m
--lua:
--vim.opt.errorformat = vim.opt.errorformat - '%f|%l col %c|%m'
--or the equivalent:
--vim.opt.errorformat:remove('%f|%l col %c|%m')

--pairs:
--some options expect a list of key-value pairs.
--to ilustrate this we'll use listchars:
--set listchars=tab:▸\ ,eol:↲,trail:·
--in lua we can use tables for this too:
--vim.opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

--calling vim functions:
--we can call them throught vim.fn.
--just like vim.opt, vim.fn is a meta-table, but this one is meant to provide a convenient syntax for us to call vim functions.
--we use it to call built-in functions, user defined functions and even functions of plugins that are not written in lua.
--we could for example check the neovim version like this:
--if vim.fn.has('nvim-0.7') == 1 then
--    print('we got neovim 0.7')
--end
--functions like has return 0 or 1, and in lua both are truthy.
--vimscript can have variable names that are not valid in lua, in that case you can use square brackets like this.
--vim.fn['fzf#vim#files']('~/projects', false)
--another way we can solve this is by using vim.call.
--vim.call('fzf#vim#files', '~/projects', false)
--vim.fn.somefunction() and vim.call('somefunction') have the same effect.

--if a function only receives a single argument, and that argument is a string or a table, you can omit the parenthesis.

--vim.cmd:
--use vim.cmd to call vimscript commands (or expressions) that don't have a lua equivalent.
--we can do lots of things in a single call:
--vim.cmd [[
--    syntax enable
--    colorscheme rubber
--]]
--so anything that you can't "translate" to lua you can put it in a string and pass that to vim.cmd

--source:
--source allows us to call other files written in vimscript
--for example, if you have lots of keybindings writing in vimscript but don't wish to convert them to lua right now, you can create a script called keymaps.vim and call it:
--vim.cmd 'source ~/.config/nvim/keymaps.vim'

--font:
--console Vim uses whatever font the console/terminal is using.
