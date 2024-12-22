--https://github.com/folke/flash.nvim

return {
    'folke/flash.nvim',

    event = { "BufNewFile", "BufReadPost" },

    opts = {
        search = {
            --default is true,search will wrap around the buffer
            wrap = true,
        },

        jump = {
            --default is false,when true,automatically jump when there is only one match
            autojump = false,
        },

        label = {
            --default is true,allow uppercase labels
            uppercase = true,
            --use rainbow colors to highlight labels,number between 1 and 9
            --shade:较高的阴影值可能导致标签的可见性降低。
            rainbow = { enabled = true, shade = 3, },
        },

        modes = {
            char = {
                --f,F,t,T with labels
                jump_labels = true,
                --remove ","
                --clever "f-style","f" go forward and "F" go backward whichever is used to start the search
                keys = { "f", "F", "t", "T", ";" },
                --just search in the current line
                multi_line = false,
                --when using jump labels,don't use these keys,this allows using those keys directly after the motion
                label = { exclude = "hjkliardcxv" },
            },

            search = {
                --disable flash during the regular search:/ or ?
                enabled = false,
            },
        },
    },

    config = function(_, opts)
        require('flash').setup(opts)

        require("plugins.flash-keymaps")
    end
}
