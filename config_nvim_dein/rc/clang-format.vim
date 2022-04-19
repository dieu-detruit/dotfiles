function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! s:clang_format()
    call Preserve(':silent %!clang-format -')
endfunction

function! s:cmake_format()
    call Preserve(':silent %!cmake-format -')
endfunction

if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.[ch]pp call s:clang_format()
    autocmd BufWrite,FileWritePre,FileAppendPre *.cc call s:clang_format()
    autocmd BufWrite,FileWritePre,FileAppendPre *.[ch] call s:clang_format()
    autocmd BufWrite,FileWritePre,FileAppendPre *.pde call s:clang_format()
    autocmd BufWrite,FileWritePre,FileAppendPre *.ino call s:clang_format()
  augroup END
endif

if executable('cmake-format')
  augroup cmake_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre CMakeLists.txt call s:cmake_format()
  augroup END
endif
