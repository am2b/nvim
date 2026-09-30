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

            -- ========== 1. 布局：定义"有哪些面板可用"，默认不自动打开 ==========
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size = 45,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 12,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = 0.6, -- 不超过屏幕 60% 高
                    max_width = 0.7,  -- 不超过屏幕 70% 宽
                    border = "rounded",
                    mappings = { close = { "q", "<Esc>" } },
                },
            })

            -- ========== 2. 行内变量值（virtual text）==========
            --前提：Go 的 treesitter 解析器已装（`:TSInstall go`）
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                cleared = true,                     -- 会话结束自动清除
                virt_text_pos = "eol",              -- inline=变量名旁边；想放行尾改成 "eol"
                commented = true,                   -- 用 // 注释前缀区分（配合 eol 效果最好）
                highlight_changed_variables = true, -- 值变化时高亮
                show_stop_reason = true,
            })
            vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#6b7280", italic = true })

            -- ========== 3. 断点符号 + 当前行高亮 ==========
            vim.fn.sign_define("DapBreakpoint",
                { text = "●", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
            vim.fn.sign_define("DapBreakpointCondition",
                { text = "●", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DapBreakpointRejected",
                { text = "●", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
            vim.fn.sign_define("DapLogPoint",
                { text = "●", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
            -- 当前执行行：nvim-dap 用 debugPC 组给当前行上色（源码确认），覆盖它
            vim.api.nvim_set_hl(0, "debugPC", { bg = "#1f4b8a", fg = "#ffffff" }) -- 亮蓝底；想用主题色就 link 到 Visual
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "debugPC", numhl = "debugPC" })
            vim.api.nvim_set_hl(0, "DapStopped", { fg = "#4ec9b0" })              -- 箭头亮青色

            -- ========== 4. 快捷键 ==========
            -- 调试控制（不变）
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)
            --vim.keymap.set("n", "<leader>dt", function() require("dap-go").debug_test() end)
            --vim.keymap.set("n", "<leader>dl", function() require("dap-go").debug_last_test() end)

            -- 面板按需开关
            vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end) -- 一键开/关全部面板
            --浮动窗里按 `:q` 关闭
            vim.keymap.set("n", "<leader>ds", function() require("dapui").float_element("scopes") end)
            vim.keymap.set("n", "<leader>db", function() require("dapui").float_element("breakpoints") end)
            vim.keymap.set("n", "<leader>df", function() require("dapui").float_element("stacks") end)
            vim.keymap.set("n", "<leader>dw", function() require("dapui").float_element("watches") end)
            vim.keymap.set("n", "<leader>dn", function() require("dapui").float_element("console") end)
            vim.keymap.set("n", "<leader>dc", dap.repl.open) -- REPL（你已有）

            -- 悬停看值（VS 鼠标悬停的等价物）
            vim.keymap.set("n", "<leader>de", function() require("dapui").eval() end)
            vim.keymap.set("v", "<leader>de", function() require("dapui").eval() end)

            require("dap-go").setup()

            -- ========== 调试状态徽标（供 lualine 读取）==========
            vim.g.dap_active = false

            local function refresh_status()
                vim.cmd("redrawstatus") -- 让 lualine 立即重绘
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
        end

    }
}
