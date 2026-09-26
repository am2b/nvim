require("core.keymaps")
require("core.text-objects")
require("core.auto-cmds")
require("core.abbreviations")
require("core.provider")

--为什么每个目录都有个init.lua?
--lua的require规则:require('core')会自动寻找lua/core/init.lua,所以每个目录里的init.lua就是该目录模块的"入口/索引文件"

--require的查找基准是lua/目录,所以这里要写成"core.options"
