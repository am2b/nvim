--https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    --打开一个文件或新建一个文件时才加载该插件
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local lspconfig = require("lspconfig")

        local nvim_script_path = vim.fn.stdpath("config") .. "/scripts/"
        local formatters = {}
        formatters.javascript = function() vim.cmd("!" .. nvim_script_path .. "format_prettier.sh %") end
        formatters.typescript = formatters.javascript
        --.jsx
        formatters.javascriptreact = formatters.javascript
        --.tsx
        formatters.typescriptreact = formatters.javascript
        formatters.html = formatters.javascript
        formatters.css = formatters.javascript
        formatters.json = formatters.javascript
        formatters.yaml = formatters.javascript
        formatters.markdown = formatters.javascript
        formatters.python = function() vim.cmd("!" .. nvim_script_path .. "format_python.sh %") end

        --自动attach的回调函数:配置快捷键和功能增强
        --会在某个LSP server成功连接到buffer时被调用
        --client:是LSP客户端对象(如果用不到的话,可以用下划线代替)
        --bufnr:是当前buffer的编号,用来确保keymap只对这个buffer生效
        local on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            --跳转到定义
            map("n", "gd", vim.lsp.buf.definition, "Go to definition")
            --跳转到声明(有些语言区分定义和声明)
            map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
            --跳转到实现
            --map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
            --跳转到被引用的位置
            --map("n", "gr", vim.lsp.buf.references, "Go to references")
            --显示悬停文档
            map("n", "K", vim.lsp.buf.hover, "Hover documentation")
            --显示函数签名
            --map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

            --重命名变量
            map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
            --显示代码动作(如快速修复)
            --map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
            --格式化
            map("n", "<space>fm", function()
                local ft = vim.bo.filetype
                if formatters[ft] then
                    formatters[ft]()
                elseif ft == "go" then
                    -- 使用 gopls 格式化，然后 retab!
                    vim.lsp.buf.format({ async = true })
                    --延迟100ms,确保format执行完
                    vim.defer_fn(function()
                        --启用expandtab,retab!才会将tab替换为空格
                        vim.bo.expandtab = true
                        vim.cmd("retab!")
                    end, 100)
                else
                    vim.lsp.buf.format({ async = true })
                end
            end, "Format")

            --诊断信息相关
            --浮窗查看当前光标位置的诊断信息
            map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
            --跳转到上/下一个报错或警告
            map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
            map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        end

        --capabilities告诉LSP:neovim客户端都支持什么功能
        --LSP是客户端-服务端结构,客户端(neovim)要告诉服务端(比如Pyright):"我支持代码补全,代码片段,文档支持,跳转功能等"
        --这句意思是:
        --我们使用了nvim-cmp插件来做补全
        --它提供了一个函数,可以生成一份增强版的capabilities,告诉LSP:
        --我支持snippet补全
        --我支持文档弹窗补全
        --我支持自动触发补全等等
        --然后我们把这个capabilities传给每个语言服务器:opts.capabilities = capabilities
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        --安装和配置的语言服务器
        local servers = {
            bashls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            },
            pyright = {},
            ts_ls = {},
            gopls = {},
        }

        --初始化语言服务器
        --对于bashls = {},name是bashls,opts是{}
        for name, opts in pairs(servers) do
            opts.capabilities = capabilities
            opts.on_attach = on_attach
            lspconfig[name].setup(opts)
        end
    end,
}
