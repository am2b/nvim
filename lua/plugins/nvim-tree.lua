--https://github.com/nvim-tree/nvim-tree.lua

--please change the font used by terminal emulator

return {
    'nvim-tree/nvim-tree.lua',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    keys = {
        { "<leader>oo", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
    },

    opts = {
        filters = {
            custom = { ".git/" },
            exclude = { ".gitignore" },
        },

        git = { enable = true },

        renderer = {
            icons = {
                show = {
                    file = true,
                    folder = true,
                    git = true,
                },
            },
        },

        --otherwise,dirbuf will fail to open directory buffers
        hijack_directories = { enable = false },
    },
}
