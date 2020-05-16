" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

" ENV
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

" Load rc file
function! s:load(file) abort
    let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

call s:load('plugins')

call clang_format#enable_auto_format()

let clang_format#code_style = 'llvm'
let clang_format#detect_style_file = 1
" call clang_format#enable_auto_format()

" neocomplete
call neocomplcache#init#enable()
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Close popup by <Enter>.
inoremap <expr><Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

"set termguicolors
set number
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamed
set smartindent

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

set synmaxcol=320

colorscheme koehler

nnoremap <silent> <C-h> ^
nnoremap <silent> <C-l> $
nnoremap <silent> <CR> A<CR><ESC>
nnoremap <silent> <CR> A<CR><ESC>

nnoremap  <silent> <C-c><C-c> :nohlsearch<CR>
nnoremap  <C-y> :%y<CR>
