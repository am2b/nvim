return {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'L3MON4D3/LuaSnip' },
    event = { 'InsertEnter', 'CmdlineEnter' },

    opts = {
        keymap = {
            --不用任何预设
            preset = 'none',

            --tab:
            --片段激活就跳到下一个位置
            --补全菜单打开就选择下一项
            --否则插入tab
            ['<tab>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.snippet_forward()
                    elseif cmp.is_visible() then
                        return cmp.select_next()
                    end
                end,
                'fallback',
            },

            --s-tab:
            --片段激活就后退
            --补全菜单打开就选择上一项
            ['<s-tab>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.snippet_backward()
                    elseif cmp.is_visible() then
                        return cmp.select_prev()
                    end
                end,
                'fallback',
            },

            --上下选择
            ['<c-n>'] = { 'select_next', 'fallback' },
            ['<c-p>'] = { 'select_prev', 'fallback' },

            --确认选择(使用该项)
            ['<cr>'] = { 'accept', 'fallback' },

            --文档滚动
            ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<c-f>'] = { 'scroll_documentation_down', 'fallback' },
        },

        completion = {
            --关键字匹配范围:
            --prefix:只匹配光标前
            --full:光标前后都匹配
            keyword = { range = 'full' },

            accept = {
                auto_brackets = { enabled = true },
            },

            list = {
                selection = {
                    --自动选中第一项
                    preselect = true,
                    auto_insert = true,
                },
            },

            menu = {
                --输入时自动弹出
                auto_show = true,

                border = 'rounded',

                --菜单布局:标签+描述|图标+类型
                draw = {
                    columns = {
                        { 'label',     'label_description', gap = 1 },
                        { 'kind_icon', 'kind' },
                    },
                    --用treesitter高亮LSP补全项的标签
                    treesitter = { 'lsp' },
                },
            },

            --文档
            documentation = {
                --选中项时自动显示文档
                auto_show = true,
                --延迟 500ms 避免闪烁
                auto_show_delay_ms = 500,
                window = { border = 'rounded' },
            },

            ghost_text = {
                enabled = true,
            },
        },

        --函数签名
        --不要和原生vim.lsp.buf.signature_help同时启用
        signature = {
            enabled = true,
            window = { border = 'rounded' },
        },

        --设置代码片段引擎
        snippets = {
            preset = 'luasnip',
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },

            providers = {
                --配置buffer源
                buffer = {
                    opts = {
                        --只从普通文件buffer取词(排除terminal/help等特殊buffer)
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ''
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                },
            },
        },

        --cmdline = {
        --    enabled = true,
        --    sources = {
        --        [':'] = { 'path', 'cmdline' },
        --        ['/'] = { 'buffer' },
        --        ['?'] = { 'buffer' },
        --    },
        --    completion = {
        --        menu = {
        --            auto_show = true,
        --            --cmdline菜单自动继承全局completion.menu.border
        --            draw = {
        --                columns = {
        --                    { 'label',     'label_description', gap = 1 },
        --                    { 'kind_icon', 'kind' },
        --                },
        --            },
        --        },
        --    },
        --    keymap = {
        --        ['<cr>'] = { 'accept_and_enter', 'fallback' },
        --    },
        --},

        --模糊匹配引擎
        --rust:预编译二进制(推荐,快且抗拼写错误)
        --version = '1.*':会自动下载预构建的二进制
        --lua:纯Lua实现(不需要二进制,稍慢)
        fuzzy = {
            implementation = 'rust',
        },
    },
}

--cmdline补全还有问题(2026-09-21)
