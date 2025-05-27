return {
    --hrsh7th/nvim-cmp:自动补全框架的主插件
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        --下面这些插件提供了cmp的补全来源
        --从LSP获取补全内容
        "hrsh7th/cmp-nvim-lsp",
        --当前buffer中已经输入过的词
        "hrsh7th/cmp-buffer",
        --文件路径补全(比如"require","import"后面)
        "hrsh7th/cmp-path",
        --命令行模式下补全,比如:edit
        "hrsh7th/cmp-cmdline",

        --片段引擎
        "L3MON4D3/LuaSnip",
        --将cmp和LuaSnip连接起来
        "saadparwaiz1/cmp_luasnip",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            completion = {
                --关闭自动弹出
                autocomplete = false,
            },
            mapping = {
                --将<tab>映射为:如果菜单未打开,则触发cmp.complete()显示菜单,否则跳转或选中
                ["<tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        cmp.complete()
                    end
                end,
                ["<s-tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
                --select = true表示如果你没有手动选择,那么就默认选择第一个
                ["<cr>"] = require("cmp").mapping.confirm({ select = true }),
            },

            --告诉cmp:补全项里如果包含snippet(例如Python中的for自动生成循环),就交给LuaSnip展开
            snippet = {
                expand = function(args)
                    --args.body是snippet的实际内容(如"for i in range(...):")
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            --设置补全源
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "luasnip" },
                { name = "path" },
            }),

            formatting = {
                format = function(entry, vim_item)
                    local source_names = {
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        luasnip = "[Snippet]",
                        path = "[Path]",
                    }
                    --设置补全菜单中每一项右边显示的标签(比如[LSP]等)
                    --vim_item.menu是nvim-cmp中每条补全项的右侧显示来源的标签
                    --entry.source.name是补全项的来源名字,比如"nvim_lsp","buffer"等
                    --所以这一行的意思是:如果在source_names中定义了这个source的名字,就显示对应的值,否则就用source_name本身来显示
                    vim_item.menu = source_names[entry.source.name] or "[" .. entry.source.name .. "]"
                    return vim_item
                end,
            },
        })
    end,
}
