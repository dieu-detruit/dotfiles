" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#max_list = 1
let g:deoplete#enable_refresh_always = 1

"- <TAB>: completion.
imap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"- <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"


" deoplete clang
let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm@10/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm@10'

" lexima (parenthese completion)
call lexima#add_rule({'char': '<', 'input_after': '>', 'filetype': 'cpp'})
call lexima#add_rule({'char': '>', 'at': '\%#>', 'leave': 1, 'filetype': 'cpp'})
call lexima#add_rule({'char': '<BS>', 'at': '<\%#>', 'delete': 1, 'filetype': 'cpp'})
set matchpairs& matchpairs+=<:>

" parenmatch ( faster parenthese hilighter than standard )
let g:loaded_matchparen = 1
