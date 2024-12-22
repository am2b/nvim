vim.loader.enable()

require("core")
require("plugins")
require("tools")

--neovim will search in every directory in the runtimepath for a folder called lua
--Lua files located in some special directories in runtimepath can be loaded automatically by neovim:
--colors/
--compiler/
--ftplugin/
--indent/
--plugin/
--syntax/
--note:in a runtime directory,all *.vim files are sourced before *.lua files.

--loads lua/module/init.lua
--require('module')
