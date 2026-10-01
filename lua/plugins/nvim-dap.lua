return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {
            -- 变量/调用栈/监视侧边栏
            "rcarriga/nvim-dap-ui",
            -- dap-ui的依赖
            "nvim-neotest/nvim-nio",
            -- 当前行内联显示变量值
            "theHamsta/nvim-dap-virtual-text",
            -- Go专属:注册dlv配置
            "leoluz/nvim-dap-go",
        },

        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- 布局:定义"有哪些面板可用",默认不自动打开
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            --四个面板在侧栏内的占比(0.25 = 各占 1/4)
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        --左侧栏宽度(列数)
                        size = 45,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        --底部高度(行数)
                        size = 12,
                        position = "bottom",
                    },
                },
                floating = {
                    --不超过屏幕60%高,不超过屏幕70%宽
                    max_height = 0.6,
                    max_width = 0.7,
                    border = "rounded",
                    mappings = { close = { "q", "<Esc>" } },
                },
            })

            --行内变量值(virtual text)
            --前提:
            --Go的treesitter解析器已安装:TSInstall go
            --Python的treesitter解析器已安装:TSInstall python
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                --会话结束自动清除
                cleared = true,
                --inline:变量名旁边,eol:行尾
                virt_text_pos = "eol",
                --用//注释前缀区分
                commented = true,
                --值变化时高亮
                highlight_changed_variables = true,
                show_stop_reason = true,
            })
            vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#6b7280", italic = true })

            --断点符号
            vim.fn.sign_define("DapBreakpoint",
                { text = "●", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
            vim.fn.sign_define("DapBreakpointCondition",
                { text = "●", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DapBreakpointRejected",
                { text = "●", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
            vim.fn.sign_define("DapLogPoint",
                { text = "●", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })

            --当前行高亮(用debugPC组上色)
            -- 亮蓝底
            vim.api.nvim_set_hl(0, "debugPC", { bg = "#1f4b8a", fg = "#ffffff" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "debugPC", numhl = "debugPC" })
            -- 箭头:亮青色
            vim.api.nvim_set_hl(0, "DapStopped", { fg = "#4ec9b0" })

            --调试状态徽标(供lualine读取)
            vim.g.dap_active = false

            local function refresh_status()
                --让lualine立即重绘
                vim.cmd("redrawstatus")
            end

            dap.listeners.after.event_initialized["dap_status_badge"] = function()
                vim.g.dap_active = true
                refresh_status()
            end
            dap.listeners.before.event_terminated["dap_status_badge"] = function()
                vim.g.dap_active = false
                refresh_status()
            end
            dap.listeners.before.event_exited["dap_status_badge"] = function()
                vim.g.dap_active = false
                refresh_status()
            end

            --快捷键
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)

            --一键开/关全部面板
            vim.keymap.set("n", "<space>du", function() require("dapui").toggle() end)

            --浮动窗里按:q关闭
            vim.keymap.set("n", "<space>ds", function() require("dapui").float_element("scopes") end)
            vim.keymap.set("n", "<space>db", function() require("dapui").float_element("breakpoints") end)
            vim.keymap.set("n", "<space>df", function() require("dapui").float_element("stacks") end)
            vim.keymap.set("n", "<space>dw", function() require("dapui").float_element("watches") end)
            vim.keymap.set("n", "<space>dc", function() require("dapui").float_element("console") end)
            vim.keymap.set("n", "<space>dr", dap.repl.open)

            --悬停看值
            vim.keymap.set("n", "<space>de", function() require("dapui").eval() end)
            vim.keymap.set("v", "<space>de", function() require("dapui").eval() end)

            --go
            require("dap-go").setup()
            --光标放在测试函数上
            vim.keymap.set("n", "<space>dt", function() require("dap-go").debug_test() end)
            vim.keymap.set("n", "<space>dl", function() require("dap-go").debug_last_test() end)
        end

    }
}
