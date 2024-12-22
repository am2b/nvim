local user_name = function()
    return ' ' .. os.getenv("USER")
end

local lsp_names = function()
    local clients = {}
    for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
        if client.name == 'null-ls' then
            local sources = {}
            for _, source in ipairs(require('null-ls.sources').get_available(vim.bo.filetype)) do
                table.insert(sources, source.name)
            end
            table.insert(clients, 'null-ls(' .. table.concat(sources, ', ') .. ')')
        else
            table.insert(clients, client.name)
        end
    end

    if #clients == 0 then return '' end
    return '󰚥 ' .. table.concat(clients, ',')
end

local utf_8_format = function(encoding)
    if encoding == 'utf-8' then
        return '󰭁'
    end

    return encoding
end

local filetype_icon = function(filetype)
    local icon

    if filetype == 'perl' then
        icon = ''
    end

    if filetype == 'python' then
        icon = '󱔎'
    end

    if filetype == 'lua' then
        icon = '󰬓'
    end

    if filetype == 'text' then
        icon = '󰬛'
    end

    if filetype == 'markdown' then
        icon = ''
    end

    if icon then
        return filetype .. '[' .. icon .. ']'
    else
        return filetype
    end
end

return { user_name = user_name, lsp_names = lsp_names, utf_8_format = utf_8_format, filetype_icon = filetype_icon }
