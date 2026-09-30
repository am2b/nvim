return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- 变量/调用栈/监视侧边栏
            "rcarriga/nvim-dap-ui",
            -- dap-ui的依赖
            "nvim-neotest/nvim-nio",
            -- 可选:当前行内联显示变量值
            "theHamsta/nvim-dap-virtual-text",
            -- Go专属:自动注册dlv配置
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            --dapui.setup()
            require("dapui").setup({
                layouts = {
                    {
                        elements = {
                            --**临时放大某个面板**：`:DapuiFloatElement scopes`（或 `stacks`、`watches`、`repl`）可以把单个面板弹出成浮动大窗
                            --四个面板在侧栏内的**占比**（0.25 = 各占 1/4）。想让某个面板更大，把它的占比调大、其他的调小
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            --{ id = "stacks",      size = 0.25 },
                            --{ id = "watches",     size = 0.25 },
                        },
                        --也可用 0~1 的小数表示占屏幕比例
                        size = 45, -- 左侧栏宽度（列数），默认约 40，改大即变宽
                        position = "left",
                    },
                    {
                        elements = {
                            --0.5 = 各占一半
                            --{ id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        --也可用 0~1 的小数表示占屏幕比例
                        size = 12, -- 底部高度（行数），默认 10，改大即变高
                        position = "bottom",
                    },
                },
            })

            -- 需要时按需弹出浮动面板:stacks,watches
            vim.keymap.set("n", "<leader>db", function() require("dapui").float_element("breakpoints") end)
            vim.keymap.set("n", "<leader>dw", function() require("dapui").float_element("watches") end)

            -- 注册go的launch/attach配置
            require("dap-go").setup()

            -- 对齐VS的快捷键
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)
            -- 调试控制台
            vim.keymap.set("n", "<leader>dc", dap.repl.open)
            -- 侧栏开关
            vim.keymap.set("n", "<leader>du", dapui.toggle)
            -- 调试测试(dap-go提供)
            --vim.keymap.set("n", "<leader>dt", function() require("dap-go").debug_test() end)
            --vim.keymap.set("n", "<leader>dl", function() require("dap-go").debug_last_test() end)

            -- 侧栏
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            -- 把断点符号改成红点（● 配红色高亮）
            vim.fn.sign_define("DapBreakpoint",
                { text = "●", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
            vim.fn.sign_define("DapBreakpointCondition",
                { text = "●", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DapBreakpointRejected",
                { text = "●", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
            vim.fn.sign_define("DapLogPoint",
                { text = "●", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
            -- 断点命中时当前行的箭头标记（可选，默认是 →）
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticSignInfo" })
        end,
    }

}
