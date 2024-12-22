--Node.js provider (optional)
--WARNING Missing "neovim" npm (or yarn, pnpm) package.
vim.cmd [[
    let g:loaded_node_provider = 0
]]

--Python 3 provider (optional)
vim.cmd [[
    let g:python3_host_prog=$HOME . '/.pyenv/versions/3.12.0/bin/python3'
]]
