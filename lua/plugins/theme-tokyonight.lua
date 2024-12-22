--https://github.com/folke/tokyonight.nvim

--vim.cmd是Neovim中推荐的简洁方式。
--vim.api.nvim_command是更低层次的API，提供了对Vim的完全控制，但在这个场景下用vim.cmd更加方便。
--vim.api.nvim_command("colorscheme tokyonight-night")
vim.cmd("colorscheme tokyonight-night")

require("tokyonight").setup({
    style = "night",
    --lualine中的粗体文字
    lualine_bold = true,
    --设置为false，保持不透明背景
    transparent = false,
    --集成Neovim内置终端:启用tokyonight配色在内置终端中的应用
    --在使用内置终端时保持主题一致性
    terminal_colors = true,
})
