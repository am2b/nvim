--https://github.com/rcarriga/nvim-dap-ui

--nvim-dap-ui is built on the idea of "elements". these elements are windows which provide different features.
--elements are grouped into layouts which can be placed on any side of the screen. there can be any number of layouts, containing whichever elements desired.
--elements can also be displayed temporarily in a floating window.

return {
    'rcarriga/nvim-dap-ui',

    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },

    event = "VeryLazy",

    config = function()
        require("dapui").setup({
            icons = { expanded = "", collapsed = "", current_frame = "" },

            mappings = {
                expand = { "<cr>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },

            layouts = {
                {
                    elements = {
                        { id = "scopes",      size = 0.35 },
                        { id = "stacks",      size = 0.35 },
                        { id = "watches",     size = 0.15 },
                        { id = "breakpoints", size = 0.15 },
                    },
                    size = 0.3,
                    position = "left"
                },
                {
                    elements = { "repl", "console" },
                    size = 0.2,
                    position = "bottom",
                },
            },

            controls = { enabled = false },

            floating = {
                max_height = 0.85,
                max_width = 0.85,
                border = "single",
                mappings = { close = { "q", "<esc>" }, },
            },

            windows = { indent = 1 },

            render = { max_type_length = nil, max_value_lines = 100 },
        })

        vim.keymap.set({ 'n', 'v' }, '<leader>dh', function() require('dap.ui.widgets').hover() end)
        vim.keymap.set({ 'n', 'v' }, '<leader>dp', function() require('dap.ui.widgets').preview() end)
        vim.keymap.set('n', '<leader>df',
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end)
        vim.keymap.set('n', '<leader>ds',
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end)

        local dap, dapui = require("dap"), require("dapui")
        --use nvim-dap events to open and close the windows automatically
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end
}
