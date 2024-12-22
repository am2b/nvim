nnoremap <buffer> <left> <pageup>
nnoremap <buffer> <right> <pagedown>
nnoremap <buffer> <up> k
nnoremap <buffer> <down> j

let b:undo_ftplugin = "unmap <buffer> <left>"
let b:undo_ftplugin = "unmap <buffer> <right>"
let b:undo_ftplugin = "unmap <buffer> <up>"
let b:undo_ftplugin = "unmap <buffer> <down>"
