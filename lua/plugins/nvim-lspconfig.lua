--https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    --打开一个文件或新建一个文件时才加载该插件
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local nvim_script_path = vim.fn.stdpath("config") .. "/scripts/"

        --异步执行外部命令,防止分页,阻塞
        local function async_sh(cmd, opts)
            opts = opts or {}
            vim.fn.jobstart(cmd, {
                on_exit = function(_, code)
                    if code == 0 then
                        if not opts.silent then
                            vim.notify("✅ 格式化完成", vim.log.levels.INFO)
                        end
                        --可选:自动刷新buffer,确保格式化后的文件立即更新
                        vim.cmd("checktime")
                    else
                        vim.notify("❌ 格式化失败:" .. table.concat(cmd, " "), vim.log.levels.ERROR)
                    end
                end,
            })
        end

        local formatters = {}
        formatters.sh = function()
            async_sh({ "shfmt", "-i", "4", "-ci", "-sr", "-w", vim.fn.expand("%") })
        end
        formatters.bash = formatters.sh
        local prettier_fmt = function()
            async_sh({ nvim_script_path .. "format_prettier.sh", vim.fn.expand("%") })
        end
        formatters.javascript = prettier_fmt
        formatters.typescript = prettier_fmt
        formatters.javascriptreact = prettier_fmt
        formatters.typescriptreact = prettier_fmt
        formatters.html = prettier_fmt
        formatters.css = prettier_fmt
        formatters.json = prettier_fmt
        formatters.yaml = prettier_fmt
        formatters.markdown = prettier_fmt
        formatters.python = function()
            async_sh({ nvim_script_path .. "format_python.sh", vim.fn.expand("%") })
        end

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
            --显示悬停文档
            --map("n", "K", vim.lsp.buf.hover, "Hover documentation")

            --重命名变量
            --map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

            --格式化
            map("n", "<space>fm", function()
                local ft = vim.bo.filetype
                if formatters[ft] then
                    --使用外部格式化器(异步)
                    formatters[ft]()
                elseif ft == "go" then
                    --同步格式化:阻塞直到gopls写完,再立即转tab为空格,无竞态
                    vim.lsp.buf.format({ async = false })
                    vim.bo.expandtab = true
                    vim.cmd("retab!")

                    --可能存在竞态:100ms后gopls未必已经写完,retab!可能跑在格式化之前
                    -- 使用gopls格式化,然后retab
                    --vim.lsp.buf.format({ async = true })
                    --延迟100ms,确保format执行完
                    --vim.defer_fn(function()
                        --启用expandtab,retab!才会将tab替换为空格
                        --vim.bo.expandtab = true
                        --vim.cmd("retab!")
                    --end, 100)
                else
                    --使用默认的LSP格式化
                    vim.lsp.buf.format({ async = true })
                end
            end, "Format buffer")

            --诊断信息相关
            --浮窗查看当前光标位置的诊断信息
            map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
            --跳转到上/下一个报错或警告
            map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
            map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        end

        --capabilities告诉LSP:neovim客户端都支持什么功能
        --LSP是客户端-服务端结构,客户端(neovim)要告诉服务端(比如Pyright):"我支持代码补全,代码片段,文档支持,跳转功能等"
        --然后我们把这个capabilities传给每个语言服务器:opts.capabilities = capabilities
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        --安装和配置的语言服务器
        local servers = {
            bashls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim", "hs" } },
                    },
                },
            },
            pyright = {},
            ts_ls = {},
            gopls = {},
        }

        for name, opts in pairs(servers) do
            opts.capabilities = capabilities
            opts.on_attach = on_attach
            --添加/修改名为name的LSP配置(以合并的方式)
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end
    end,
}

--neovim 0.12启动时就自动注册了lsp-defaults:
--grr:references(引用)
--gri:implementation(实现)
--gra:code_action(代码动作)
--grn:rename(重命名)
--grt:type_definition,gO:document_symbol,insert <c-s>:signature_help
