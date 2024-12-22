--https://github.com/mfussenegger/nvim-dap

--nvim-dap implements a client for the Debug Adapter Protocol, that allows us to control the debugger from inside neovim
--nvim-dap(client) communication with language-specific debugger(debug adapter) via the Debug Adapter Protocol

return {
    'mfussenegger/nvim-dap',

    dependencies = { 'mfussenegger/nvim-dap-python' },

    event = "VeryLazy",

    config = function()
        local dap = require('dap')

        --bash
        dap.adapters.bashdb = {
            type = 'executable',
            --bashdb可执行文件路径
            command = '/opt/homebrew/bin/bashdb',
            args = {
                '--quiet',
                '--tty',
                '--ttyout',
                '--library',
                --bashdb库文件路径
                '/opt/homebrew/share/bashdb',
            },
        }
        dap.configurations.sh = {
            {
                name = 'Debug bash file',
                type = 'bashdb',
                request = 'launch',
                program = '${file}',
                cwd = '${workspaceFolder}',
                --bashdb可执行文件路径
                pathBashdb = '/opt/homebrew/bin/bashdb',
                --bashdb库文件路径
                pathBashdbLib = '/opt/homebrew/share/bashdb',
                pathCat = 'cat',
                pathBash = '/bin/bash',
                pathMkfifo = 'mkfifo',
                pathPkill = 'pkill',
                args = {},
                env = {},
                terminalKind = 'integrated',
            },
        }

        --python
        dap.adapters.python = {
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
        }
        dap.configurations.python = {
            {
                name = 'Debug python file',
                type = 'python',
                request = 'launch',
                --调试当前文件
                program = '${file}',
                pythonPath = function()
                    --使用os.getenv("HOME")来获取用户的主目录
                    --todo:可以把python的版本号做成环境变量
                    return os.getenv("HOME") .. '/.pyenv/versions/3.12.0/bin/python'
                end,
            },
        }

        --lua
        dap.adapters.lua = {
            type = 'server',
            host = '127.0.0.1',
            --mobdebug默认监听的端口
            port = 8172,
        }
        dap.configurations.lua = {
            {
                name = 'Debug lua file',
                type = 'lua',
                request = 'attach',
                --调试当前文件
                program = '${file}',
                cwd = vim.fn.getcwd(),
            },
        }

        --go
        dap.adapters.go = {
            type = 'server',
            host = '127.0.0.1',
            port = 38697,
            executable = {
                command = 'dlv',
                --delve监听dap请求的端口号
                --检查端口是否被占用(没有输出则表示可以安全使用):
                --lsof -i :38697
                args = { 'dap', '-l', '127.0.0.1:38697' },
            }
        }
        dap.configurations.go = {
            {
                name = 'Debug go file',
                type = "go",
                request = "launch",
                --调试当前文件
                program = "${file}",
            },
        }

        --swift
        dap.adapters.lldb = {
            type = 'executable',
            command = '/usr/bin/lldb',
            name = "lldb"
        }
        dap.configurations.swift = {
            {
                name = "Debug swift file",
                type = "lldb",
                request = "launch",
                --配置了一个program函数,用于在启动调试时提示你输入要调试的swift可执行文件的路径
                --择要调试的swift程序
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                --这是程序运行时传入的参数,如果没有额外的参数,可以保持为空
                args = {},
                --如果设置为true,调试器将在外部终端中运行swift程序
                runInTerminal = false,
            },
        }

        vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "DAP:continue" })
        vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, { desc = "DAP:step over" })
        vim.keymap.set('n', '<F7>', function() require('dap').step_into() end, { desc = "DAP:step into" })
        vim.keymap.set('n', '<F8>', function() require('dap').step_out() end, { desc = "DAP:step out" })
        vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = "DAP:toggle breakpoint" })

        --vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = "DAP:open REPL" })
        vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = "DAP:run last" })

        require("plugins.dap-icons")
    end
}

--常用命令:
--:DapToggleBreakpoint,在当前行添加/删除断点
--:DapContinue,启动或继续调试程序
--:DapStepOver,单步跳过当前函数
--:DapStepInto,单步进入函数内部
--:DapStepOut,跳出当前函数
--:DapTerminate,停止调试
