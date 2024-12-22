--n:normal mode,
--i:insert mode
--x:visual mode
--c:command mode
--s:selection mode
--v:visual + selection
--t:terminal mode
--o:operator-pending
--!:insert + command
--'':normal + visual + selection + operator-pending

local keymap = vim.keymap

--text object of a line
--<c-u>:delete everything already written in command-line mode (like the selection markers '<,'> for example)
--normal!:this ex-command allow executing normal mode keystrokes
keymap.set("o", "il", ":<c-u>normal! $v^<cr>",
    { silent = true, desc = "text-object:a line without the indentations" })
keymap.set("x", "il", ":<c-u>normal! $v^<cr>",
    { silent = true, desc = "text-object:a line without the indentations" })
keymap.set("o", "al", ":<c-u>normal! V<cr>",
    { silent = true, desc = "text-object:a line with the indentations" })
keymap.set("x", "al", ":<c-u>normal! V<cr>",
    { silent = true, desc = "text-object:a line with the indentations" })

--text object between two characters
local function basic_text_objects()
    local chars = { '!', '@', '#', '$', '%', '^', '&', '*', '-', '_', '=', '+', '`', '~', '|', '\\', ';', ':', ',', '.',
        '/', '?', ' ' }
    for _, char in ipairs(chars) do
        for _, mode in ipairs({ 'o', 'x' }) do
            --:silent!,it will force normal! to execute till the end
            keymap.set(mode, "i" .. char, string.format(":<c-u>silent! normal! f%sF%slvt%s<cr>", char, char, char),
                { silent = true, desc = "text object between two characters:inside" })
            keymap.set(mode, "a" .. char, string.format(":<c-u>silent! normal! f%sF%svf%s<cr>", char, char, char),
                { silent = true, desc = "text object between two characters:around" })
        end
    end
end

basic_text_objects()

--text objects based on indentations
local function is_blank_line(line, blank_line_pattern)
    return string.match(vim.fn.getline(line), blank_line_pattern)
end

function SELECT_INDENT(around)
    --get the starting indentation of the current line.this will be the indentation of reference we'll compare every other line to
    local start_indent = vim.fn.indent(vim.fn.line('.'))

    --regexes in lua are a bit odd: where you would have \s for representing white spaces in many other regex engines, you have %s in lua
    local blank_line_pattern = '^%s*$'

    --ignore the keystroke
    if string.match(vim.fn.getline('.'), blank_line_pattern) then
        return
    end

    --v2ii would select a lower level of indentation, and v3ii would select even more.
    --to do so, we simply need to increase our starting indentation depending on the count given.
    --vim.v.count is the count given to the text-object
    if vim.v.count > 0 then
        start_indent = start_indent - vim.o.shiftwidth * (vim.v.count - 1)
        --verify if our starting indentation is lower than 0, which could happen if we enter a count on a line without any indentation
        if start_indent < 0 then
            start_indent = 0
        end
    end

    local prev_line = vim.fn.line('.') - 1
    --move up line by line, as long as the indentation is equal or higher to the starting indentation
    while prev_line > 0 and (is_blank_line(prev_line, blank_line_pattern) or vim.fn.indent(prev_line) >= start_indent) do
        --use the ex-command - and + to move up and down
        vim.cmd('-')
        prev_line = vim.fn.line('.') - 1
    end
    --"around" the text-object should select two more lines
    if around then
        vim.cmd('-')
    end

    --enter visual mode
    vim.cmd('normal! 0V')

    local next_line = vim.fn.line('.') + 1
    local last_line = vim.fn.line('$')
    --move down till the indentation is equal or higher to the starting indentation
    while next_line <= last_line and (is_blank_line(next_line, blank_line_pattern) or vim.fn.indent(next_line) >= start_indent) do
        vim.cmd('+')
        next_line = vim.fn.line('.') + 1
    end
    --“around” the text-object should select two more lines
    if around then
        vim.cmd('+')
    end
end

local function indent_text_objects()
    for _, mode in ipairs({ 'o', 'x' }) do
        keymap.set(mode, 'ii', ':<c-u>lua SELECT_INDENT()<cr>',
            { silent = true, desc = "text objects based on indentations:inside" })
        keymap.set(mode, 'ai', ':<c-u>lua SELECT_INDENT(true)<cr>',
            { silent = true, desc = "text objects based on indentations:around" })
    end
end

indent_text_objects()
