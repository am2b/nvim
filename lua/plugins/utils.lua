local user_name = function()
    return ' ' .. (vim.env.USER or 'unknown')
end

local utf_8_format = function(encoding)
    if encoding == 'utf-8' then
        return '󰭁'
    end

    return encoding
end

local filetype_icon = function(filetype)
    local icons = {
        perl = '',
        python = '󱔎',
        lua = '󰬓',
        text = '󰬛',
        markdown = '',
    }

    local icon = icons[filetype]

    return filetype .. (icon and '[' .. icon .. ']' or '')
end

return { user_name = user_name, utf_8_format = utf_8_format, filetype_icon = filetype_icon }
