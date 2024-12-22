--https://github.com/nvim-treesitter/nvim-treesitter
--https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--https://github.com/RRethy/nvim-treesitter-textsubjects

--nvim-treesitter是一个基于Tree-sitter的插件,它能够为neovim提供更强大的语法解析和高亮功能
--相比传统的正则表达式解析,它使用抽象语法树(AST)提供了更准确的语法解析

--主要功能包括:
--语法高亮:提供基于语言的精确高亮,支持多种语言
--代码缩进:根据语法树更准确的缩进设置
--增量选择:逐步扩展或收缩代码选择区域
--文本对象:基于语法树的文本操作,比如选择函数或块
--代码折叠:基于语法树提供的代码折叠功能

return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",

    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'RRethy/nvim-treesitter-textsubjects' },

    event = { 'BufNewFile', 'BufReadPost' },

    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            --by default, everything is disabled
            ensure_installed = { "bash", "c", "diff", "go", "json", "lua", "perl", "python", "ruby", "swift", "tmux", "toml", "vim", "yaml" },

            highlight = {
                --启用语法高亮
                enable = true,
                --关闭额外的vim正则语法高亮,避免冲突
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
                --可以根据需要关闭某些语言的自动缩进
                --neovim自带的Python缩进规则经过长时间的使用和优化,通常在处理Python代码时更加可靠
                --disable = { "python" }
            },

            --init_selection:in normal mode, start incremental selection.defaults to 'gnn'
            --node_incremental:in visual mode, increment to the upper named parent.defaults to 'grn'
            --node_decremental:in visual mode, decrement to the previous named node.default to 'grm'
            --scope_incremental:in visual mode, increment to the upper scope.defaults to 'grc'
            incremental_selection = {
                enable = true,
                keymaps = {
                    --开始选择
                    init_selection = "gnn",
                    --增大选择
                    node_incremental = "grn",
                    --减少选择
                    node_decremental = "grm",
                },
            },

            textobjects = {
                select = {
                    enable = true,
                    --自动跳转到下一个匹配对象
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                    },
                },
                move = {
                    enable = true,
                    --在跳转时记录到jumplist
                    set_jumps = true,
                    goto_next_start = {
                        --跳转到下一个函数的开头
                        ["[b"] = "@function.outer",
                    },
                    goto_next_end = {
                        --跳转到下一个函数的结尾
                        ["[e"] = "@function.outer",
                    },
                    goto_previous_start = {
                        --跳转到上一个函数的开头
                        ["]b"] = "@function.outer",
                    },
                    goto_previous_end = {
                        --跳转到上一个函数的结尾
                        ["]e"] = "@function.outer",
                    },
                },
            },

            textsubjects = {
                enable = true,
                --usage:v.|v;|vi;|v,
                keymaps = {
                    ["."] = "textsubjects-smart",
                    [";"] = "textsubjects-container-outer",
                    ['i;'] = "textsubjects-container-inner",
                },
                --上次选择的快捷键
                prev_selection = ",",
            },
        })
    end
}
