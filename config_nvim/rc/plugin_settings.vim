" deoplete
let g:deoplete#enable_at_startup = 1

"- <TAB>: completion.
imap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"- <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"


" deoplete clang

" parenmatch ( faster parenthese hilighter than standard )
let g:loaded_matchparen = 1
