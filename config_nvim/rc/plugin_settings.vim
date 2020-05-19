" python settings
let g:python_host_prog = '/Users/dieu_detruit/dotfiles/pyenv/versions/2.7.17/envs/forvim2/bin/python'
let g:python3_host_prog = '/Users/dieu_detruit/dotfiles/pyenv/versions/3.7.3/envs/forvim/bin/python3'

" deoplete
let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_ignore_case = 1
    let g:deoplete#enable_smart_case = 1

    " <TAB>: completion.
    imap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    " <S-TAB>: completion back.
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" lexima (parenthese completion)
call lexima#add_rule({'char': '<', 'input_after': '>', 'filetype': 'cpp'})
