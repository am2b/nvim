--https://github.com/theHamsta/nvim-dap-virtual-text

--puts the variable values into the virtual text

return {
    'theHamsta/nvim-dap-virtual-text',

    dependencies = { 'mfussenegger/nvim-dap' },

    event = "VeryLazy",

    config = function()
        require("nvim-dap-virtual-text").setup {
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            display_callback = function(variable)
                return variable.name .. ' = ' .. variable.value
            end,
            virt_text_pos = 'eol',
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil
        }
    end
}
