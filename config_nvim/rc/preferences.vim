set number
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamed
set smartindent

" tab settings for each file type
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" Max column syntax works to read the file on time
set synmaxcol=320

" colorscheme
colorscheme koehler

" keymapping
let mapleader = " "

nmap <Leader>w [window]
nnoremap [window]h <C-w>h
nnoremap [window]j <C-w>j
nnoremap [window]k <C-w>k
nnoremap [window]l <C-w>l

nnoremap  <silent> <C-c><C-c> :nohlsearch<CR>

nnoremap <silent> <CR> A<CR><ESC>
