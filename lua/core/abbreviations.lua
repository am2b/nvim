--:iabbrev [<expr>] [<buffer>] {abbreviation} {expansion}
--in here anything that's inside a [] is optional.
--<expr> means that you could use a vimscript expression to create the expansion.
--<buffer> means that it only applies to the current buffer.
--abbreviation is the thing you type and that will be replaced by the expansion.

--note:
--trigger:ctrl+]

local augroup_bash = vim.api.nvim_create_augroup('autocmds_bash', { clear = true })
local augroup_python = vim.api.nvim_create_augroup('autocmds_python', { clear = true })
local augroup_perl = vim.api.nvim_create_augroup('autocmds_perl', { clear = true })
local augroup_ruby = vim.api.nvim_create_augroup('autocmds_ruby', { clear = true })

--bash
vim.api.nvim_create_autocmd('FileType', {
    group = augroup_bash,
    pattern = "sh",
    desc = "abbreviation:#! for bash",
    command = "inoreabbrev <buffer> sb$ #!/bin/bash",
})

--python
vim.api.nvim_create_autocmd('FileType', {
    group = augroup_python,
    pattern = "python",
    desc = "abbreviation:#! for python",
    command = "inoreabbrev <buffer> sb$ #!/usr/bin/env python",
})

--perl
vim.api.nvim_create_autocmd('FileType', {
    group = augroup_python,
    pattern = "perl",
    desc = "abbreviation:#! for perl",
    command = "inoreabbrev <buffer> sb$ #!/usr/bin/env perl",
})

--ruby
vim.api.nvim_create_autocmd('FileType', {
    group = augroup_ruby,
    pattern = "ruby",
    desc = "abbreviation:#! for ruby",
    command = "inoreabbrev <buffer> sb$ #!/usr/bin/env ruby",
})
