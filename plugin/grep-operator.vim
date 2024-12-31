"说明:
"normal mode:<leader>gw:使用grep搜索一个单词
"visual mode:<leader>g:使用grep搜索被选中的内容
"<space>cc:关闭Quickfix List

"First we set the operatorfunc option to our function, and then we run g@ which calls this function as an operator.
"<SID>:to find the function in the script's namespace,:help <SID>
nnoremap <silent> <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@

"<c-u>:
"Try visually selecting some text and pressing :. Vim will open a command line as it usually does when : is pressed, but it automatically fills in '<,'> at the beginning of the line!
"Vim is trying to be helpful and inserts this text to make the command you're about to run function on the visually selected range. In this case, however, we don't want the help. We use <c-u> to say "delete from the cursor to the beginning of the line", removing the text. This leaves us with a bare :, ready for the call command.
"visualmode():
"This function is a built-in Vim function that returns a one-character string representing the last type of visual mode used: "v" for characterwise, "V" for linewise, and a Ctrl-v character for blockwise.
vnoremap <silent> <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

"s:places function in the current script's namespace
"type:motion types
"when we use the operator from normal mode it will be char or line
"when we use the operator from visual mode it will be the result of visualmode()
function! s:GrepOperator(type)
    "save the contents of the unnamed register before we yank in all cases so that we can restore it after we're done.
    let saved_unnamed_register = @@

    "If the type is 'v' it was called from characterwise visual mode
    "Notice that we use the case-sensitive comparison ==#. If we used plain == and the user has ignorecase set it would match "V" as well
    if a:type ==# 'v'
        normal! `<v`>y
    "if the operator was called from normal mode using a characterwise motion
    elseif a:type ==# 'char'
        normal! `[v`]y
    "We explicitly ignore the cases of linewise/blockwise visual mode and linewise/blockwise motions. Grep doesn't search across lines by default, so having a newline in the search pattern doesn't make any sense!
    else
        return
    endif

    "Remember that variables starting with an @ are registers. @@ is the "unnamed" register: the one that Vim places text into when you yank or delete without specify a particular register.
    "use grepprg
    silent execute "grep " . shellescape(@@)
    copen

    let @@ = saved_unnamed_register
endfunction

"Each of our two if cases runs a normal! command that does two things:
"1,Visually select the range of text we want by:
"    a,Moving to mark at the beginning of the range.
"    b,Entering characterwise visual mode.
"    c,Moving to the mark at the end of the range.
"2,Yanking the visually selected text.

":help visualmode()
":help c_ctrl-u
":help operatorfunc
":help map-operator
