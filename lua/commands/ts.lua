local builtin = require("telescope.builtin")

local function T(name, picker)
    vim.api.nvim_create_user_command(name, function()
        picker()
    end, {})
end

--模糊查找:当前buffer
T('TSBufFind', builtin.current_buffer_fuzzy_find)

--需要光标位于某个identifier处
--查看一个函数/变量在哪里被引用
T('TSLspRef', builtin.lsp_references)
--跳转到定义
T('TSLspDef', builtin.lsp_definitions)
--跳转到interface/method的实现
T('TSLspImpl', builtin.lsp_implementations)

--list keymappings of normal mode
T('TSKeyMaps', builtin.keymaps)

--Git
--查看修改
T('TSGitStatus', builtin.git_status)
--查看历史commits
T('TSGitCommits', builtin.git_commits)
--查当前buffer是哪个commit改的
T('TSGitBufCommits', builtin.git_bcommits)

--lists available plugin/user commands and runs them on <cr>
T('TSPluginUserCmds', builtin.commands)

--列出lsp所报的问题:错误,警告,提示等
T('TSDiagnostics', builtin.diagnostics)

--Treesitter
--列出当前buffer的treesitter节点(当某个语言的LSP没有正常工作时)
T('TSTreesitter', builtin.treesitter)

--lists built-in pickers and run them on <cr>
T('TSPickers', builtin.builtin)
