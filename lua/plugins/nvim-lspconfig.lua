--https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    --打开一个文件或新建一个文件时才加载该插件
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        --外部格式化器
        local nvim_script_path = vim.fn.stdpath("config") .. "/scripts/"
        --异步执行外部命令,防止分页,阻塞,捕获子进程输出用于报错定位
        local function async_sh(cmd, opts)
            opts = opts or {}
            local output = {}
            local job = vim.fn.jobstart(cmd, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = function(_, data)
                    if data then
                        output[#output + 1] = table.concat(data, "\n")
                    end
                end,
                on_stderr = function(_, data)
                    if data then
                        output[#output + 1] = table.concat(data, "\n")
                    end
                end,
                on_exit = function(_, code)
                    if code == 0 then
                        if not opts.silent then
                            vim.notify("✅ 格式化完成", vim.log.levels.INFO)
                        end
                        --重载buffer,确保格式化后的文件立即更新
                        vim.cmd("checktime")
                    else
                        vim.notify(
                            "❌ 格式化失败: " .. table.concat(cmd, " ") .. "\n" .. table.concat(output, "\n"),
                            vim.log.levels.ERROR
                        )
                    end
                end,
            })
            if job <= 0 then
                vim.notify("❌ 无法启动进程: " .. table.concat(cmd, " "), vim.log.levels.ERROR)
            end
        end

        local formatters = {}
        formatters.sh = function()
            async_sh({ "shfmt", "-i", "4", "-ci", "-sr", "-w", vim.fn.expand("%:p") })
        end
        formatters.bash = formatters.sh
        local prettier_fmt = function()
            async_sh({ nvim_script_path .. "format_prettier.sh", vim.fn.expand("%:p") })
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
            async_sh({ nvim_script_path .. "format_python.sh", vim.fn.expand("%:p") })
        end

        --------------------------------------------------

        --Format buffer
        local function format_buffer()
            local ft = vim.bo.filetype

            --外部格式化器(shfmt/prettier/python):操作的是磁盘文件
            if formatters[ft] then
                --先存盘,否则格式化的是磁盘旧内容
                if vim.bo.modified and vim.fn.expand("%:p") ~= "" then
                    vim.cmd("write")
                end
                --使用外部格式化器(异步)
                formatters[ft]()
                return
            end

            if ft == "go" then
                if #vim.lsp.get_clients({ bufnr = 0, capability = "textDocument/formatting" }) == 0 then
                    vim.notify("没有支持格式化的LSP附着,请确认gopls已安装且已attach", vim.log.levels.WARN)
                    return
                end
                --格式化前统一存储
                vim.cmd("write")
                --同步格式化:阻塞直到gopls写完,再立即转tab为空格,无竞态
                vim.lsp.buf.format({ async = false })
                --决定retab的方向是tab->空格
                vim.bo.expandtab = true
                --不带!:只替换作为空白部分的tab(行首缩进,空白对齐),字符串/注释里的tab不动
                vim.cmd("retab")
                --retab又改了buffer,最后落盘
                vim.cmd("write")
                return
            end

            --使用默认的LSP格式化
            --格式化前统一存储
            vim.cmd("write")
            --async = true:异步,函数会立即返回,格式化可能还没跑完,此时write保存的是没格式化过的旧buffer
            --只有同步等格式化完成,才能保存结果,代价是:文件很大或服务器很慢时,<space>fm会卡一下(默认超时5秒,可加timeout_ms = 3000 控制)
            --如果不能接受卡顿,就改成保留async = true且不加末尾的write(格式化完后手动:w)
            vim.lsp.buf.format({ async = false })
            vim.cmd("write")
        end

        --------------------------------------------------

        --inlay hints:显示参数名/推断类型等灰色小字
        --vim.keymap.set("n", "<space>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = "Toggle inlay hints" })

        --诊断浮窗圆角
        vim.diagnostic.config({ float = { border = "rounded" }, signs = true })

        --------------------------------------------------

        --LSP attach后设置buffer-local keymaps
        --LspAttach事件:处理LSP client attach到buffer后,应该做的事情
        vim.api.nvim_create_autocmd("LspAttach", {
            --给刚刚完成LSP attach的buffer设置快捷键
            callback = function(args)
                --当前buffer
                local bufnr = args.buf

                --获取刚刚attach到当前buffer的LSP client
                --args.data.client_id:刚刚attach的LSP client ID
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then
                    vim.notify("LSP attached: " .. client.name, vim.log.levels.INFO)
                end

                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                --跳转到定义
                map("n", "gd", vim.lsp.buf.definition, "Go to definition")

                --格式化
                map("n", "<space>fm", format_buffer, "Format buffer")

                --诊断信息相关
                --浮窗查看当前光标位置的诊断信息
                map("n", "<space>sd", vim.diagnostic.open_float, "Show diagnostics")

                --跳转到上/下一个报错或警告
                map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
                map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
            end,
        })

        --------------------------------------------------

        --LSP servers
        --安装和配置的语言服务器
        local servers = {
            bashls = {},

            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim", "hs" } },
                        workspace = {
                            library = { vim.env.VIMRUNTIME },
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            },

            pyright = {},
            ts_ls = {},
            gopls = {},
        }

        --------------------------------------------------

        --LSP capabilities
        --capabilities告诉LSP:neovim客户端都支持什么功能
        --LSP是客户端-服务端结构,客户端(neovim)要告诉服务端(比如Pyright):"我支持代码补全,代码片段,文档支持,跳转功能等"
        --然后我们把这个capabilities传给每个语言服务器:opts.capabilities = capabilities
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        --Enable LSP servers
        vim.lsp.config('*', { capabilities = capabilities })
        for name, opts in pairs(servers) do
            --opts.capabilities = capabilities
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
--grn:rename(重命名:光标移到符号上 -> 按grn -> 底部弹出输入框(预填当前名字) -> 输入新名字 -> Enter)
--grt:type_definition,gO:document_symbol,insert <c-s>:signature_help
--gD:跳转到声明
--K:hover documentation
