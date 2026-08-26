vim.loader.enable()

--因为<leader>在core.keymaps里设置,所以core要先于plugins加载,否则插件里使用<leader>的映射拿到的<leader>为空
require("core")
require("plugins")
require("tools")
