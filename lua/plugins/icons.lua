--https://github.com/nvim-tree/nvim-web-devicons
return {
    {
        'nvim-tree/nvim-web-devicons',

        lazy = true,
        config = function()
            require 'nvim-web-devicons'.setup {
                override = {
                    zsh = {
                        icon = "",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Zsh",
                    },
                },

                override_by_filename = {
                    [".gitignore"] = {
                        icon = "",
                        color = "#f1502f",
                        name = "Gitignore",
                    },
                },

                override_by_extension = {
                    ["log"] = {
                        icon = "󱂅",
                        color = "#81e043",
                        name = "Log",
                    },

                    ["lua"] = {
                        icon = "󰬓",
                    },

                    ["pl"] = {
                        icon = "",
                    },

                    ["py"] = {
                        icon = "󱔎",
                    },

                    ["txt"] = {
                        icon = "󰬛",
                    },
                },

                color_icons = true,
                default = true,
                strict = true,
            }
        end,
    },
}
