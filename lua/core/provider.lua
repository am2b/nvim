vim.cmd [[
    "告诉neovim:不要加载node provider,也不要在checkhealth的时候打印Missing
    "这么做的前提是:没有使用javascript写的插件,neovim也没有去调用javascript代码
    let g:loaded_node_provider = 0
    let g:loaded_perl_provider = 0
    let g:loaded_ruby_provider = 0
]]

--Python 3 provider(optional)
--vim.cmd [[
--    let g:python3_host_prog=$HOME . '/.pyenv/versions/3.12.0/bin/python3'
--]]
