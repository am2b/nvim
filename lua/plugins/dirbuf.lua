--https://github.com/elihunter173/dirbuf.nvim

--通过在目录缓冲区中编辑行来创建,复制,删除和重命名文件/目录

--usage:
--run the command :Dirbuf to open a directory buffer
--press - in any buffer to open a directory buffer for its parent

--inside a directory buffer,there are the following keybindings:
--<cr>:open the file or directory at the cursor
--gh:toggle showing hidden files (i.e. dot files)
--'-':open parent directory

return {
    'elihunter173/dirbuf.nvim',

    keys = {
        { "-", "<cmd>Dirbuf<cr>", desc = "Open Dirbuf" },
    },

    --命令:Dirbuf也是打开Dirbuf
    cmd = { "Dirbuf" },

    opts = {
        --write_cmd = "DirbufSync -confirm",
        write_cmd = "DirbufSync",
    },
}
