--https://github.com/ThePrimeagen/harpoon

return {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",

    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },

    event = { 'VeryLazy' },

    config = function()
        local harpoon = require("harpoon")

        harpoon.setup {
            menu = {
                width = math.floor(vim.api.nvim_win_get_width(0) * 0.75),
            },

            global_settings = {
                --filetypes that you want to prevent from adding to the harpoon list menu.
                excluded_filetypes = { "harpoon" },
            },
        }

        vim.keymap.set('n', 'mf', function() harpoon:list():add() end, { desc = 'Normal:Mark file by harpoon' })
        vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = 'Normal:Toggle menu of harpoon' })
        vim.keymap.set('n', '<space>hh', function() harpoon:list():prev() end,
            { desc = 'Normal:Navigates to prev marked file' })
        vim.keymap.set('n', '<space>hl', function() harpoon:list():next() end,
            { desc = 'Normal:Navigates to next marked file' })

        local harpoon_map = function(index)
            vim.keymap.set('n', '<space>' .. index, function() harpoon:list():select(index) end,
                { desc = 'Normal:Navigates to marked file by index' })
        end

        for i = 1, 9 do
            harpoon_map(i)
        end

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end
        vim.keymap.set('n', '<leader>fh', function() toggle_telescope(harpoon:list()) end,
            { desc = 'Normal:List marks of harpoon by telescope' })
    end
}
